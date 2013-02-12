require("tab-bar.js");
require("favicon");
require("clicks-in-new-buffer.js");

minibuffer_auto_complete_default = true;
read_buffer_show_icons = true; // favicons in minibuffer buffer list
homepage = "http://www.google.com";
xkcd_add_title = true; // xkcd-mode will scrape the alt text from the comic and insert it below the comic
url_remoting_fn = load_url_in_new_buffer; // load new URLs in new tabs
view_source_use_external_editor = true; // view source opens the page source in external editor
url_completion_use_history = true; // use history for URL completion
url_completion_use_bookmarks = true; // use bookmarks for URL completion
run_external_editor_function = "emacsclient -a '' -c";
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND;

session_pref("xpinstall.whitelist.required", false); // disable security to allow extension installation
session_pref('general.smoothScroll', true);
session_pref('browser.enable_automatic_image_resizing', true);

// Mode line buttons for basic browser control
load_paths.unshift("chrome://conkeror-contrib/content/");
require("mode-line-buttons.js");
mode_line_add_buttons(standard_mode_line_buttons, true);

// big hint numbers
register_user_stylesheet(
  "data:text/css," +
    escape(
      "@namespace url(\"http://www.w3.org/1999/xhtml\");\n" +
        "span.__conkeror_hint {\n"+
        "  font-size: 18px !important;\n"+
        "  line-height: 18px !important;\n"+
        "}"));

// custom webjumps
define_webjump("amazon", "http://www.amazon.com/s?ie=UTF8&field-keywords=%s&index=blended&link_code=qs");
define_webjump("archwiki", "https://wiki.archlinux.org/index.php?title=Special:Search&search=%s");
define_webjump("github", "https://github.com/search?q=%s");
define_webjump("gmail", "https://mail.google.com/mail/u/0/?ui=2&shva=1#search/%s");
define_webjump("goodreads", "http://www.goodreads.com/search?q=%s");
define_webjump("imdb", "http://imdb.com/find?q=%s");
define_webjump("readability", "javascript:(%28function%28%29%7Bwindow.baseUrl%3D%27http%3A//www.readability.com%27%3Bwindow.readabilityToken%3D%27%27%3Bvar%20s%3Ddocument.createElement%28%27script%27%29%3Bs.setAttribute%28%27type%27%2C%27text/javascript%27%29%3Bs.setAttribute%28%27charset%27%2C%27UTF-8%27%29%3Bs.setAttribute%28%27src%27%2CbaseUrl%2B%27/bookmarklet/read.js%27%29%3Bdocument.documentElement.appendChild%28s%29%3B%7D%29%28%29)");
define_webjump("SO with google", "https://www.google.co.in/?q=site:stackoverflow.com+%s#hl=en&safe=off&tbo=d&output=search&q=site:stackoverflow.com+%s")
define_webjump("torrentz", "http://torrentz.in/search?q=%s");
define_webjump("trans", "http://translate.google.com/translate_t#auto|en|%s");
define_webjump("twitter", "http://twitter.com/%s");
define_webjump("urban", "http://www.urbandictionary.com/define.php?term=%s");
define_webjump("youtube", "http://www.youtube.com/results?search_query=%s&search=Search");

// shortcuts to frequent websites. Prefix with C-u to open in a new tab
interactive("open-google", "Go to google", "follow", $browser_object = "http://google.com/");
interactive("open-gmail", "Go to gmail", "follow", $browser_object = "http://gmail.com/");
interactive("open-facebook", "Go to facebook", "follow", $browser_object = "http://facebook.com/");
interactive("open-twitter", "Go to twitter", "follow", $browser_object = "https://twitter.com/i/connect");
interactive("open-tweetdeck", "Go to tweetdeck", "follow", $browser_object = "http://web.tweetdeck.com/");
interactive("open-music-sites","opens music sites I visit frequently",
            function(I){
              load_url_in_new_buffer("http://8tracks.com",I.window);
              load_url_in_new_buffer("http://grooveshark.com",I.window);
              load_url_in_new_buffer("http://last.fm",I.window);
            });
define_key(content_buffer_normal_keymap, "f1", "open-google");
define_key(content_buffer_normal_keymap, "f2", "open-gmail");
define_key(content_buffer_normal_keymap, "f3", "open-facebook");
define_key(content_buffer_normal_keymap, "f4", "open-twitter");
define_key(content_buffer_normal_keymap, "f5", "open-tweetdeck");
define_key(content_buffer_normal_keymap, "f10", "open-music-sites");

// environment shortcuts
define_key(default_global_keymap, "C-w", "cmd_deleteWordBackward");
remove_hook("mode_line_hook", mode_line_adder(clock_widget)); // remove the annoying clock widget
add_hook("mode_line_hook", mode_line_adder(buffer_count_widget), true);

// firebug lite
define_variable("firebug_url",
                "http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js");

function firebug (I) {
  var doc = I.buffer.document;
  var script = doc.createElement('script');
  script.setAttribute('type', 'text/javascript');
  script.setAttribute('src', firebug_url);
  script.setAttribute('onload', 'firebug.init();');
  doc.body.appendChild(script);
}
interactive("firebug", "open firebug lite", firebug);

// confirm on quit
add_hook("window_before_close_hook",
         function () {
           var w = get_recent_conkeror_window();
           var result = (w == null) ||
             "y" == (yield w.minibuffer.read_single_character_option(
               $prompt = "Quit Conkeror? (y/n)",
               $options = ["y", "n"]));
           yield co_return(result);
         });

// send to RIL / open RIL list
interactive("ril", "Read it Later",
            function (I) {
              let posturl = 'https://readitlaterlist.com/v2/add?username=USERNAME&password=PASSWORD&apikey=0Z4A9y66d8cF2fMu42p9b46Zb8T2vqNq&url=' + I.buffer.display_uri_string + '&title=' + I.buffer.document.title;
              yield send_http_request(load_spec({uri: posturl}));
              I.window.minibuffer.message("Saved!");

            });
define_key(default_global_keymap, "C-r", "ril");

interactive("open-ril", "Go to Read It Later website", "follow", $browser_object = "http://www.readitlaterlist.com/unread");
define_key(default_global_keymap, "C-x r", "open-ril");

// f5 to search dict.org
// C-u f5 to search words at Levenshtein distance 1
// C-u C-u f5 to search superstrings
function dict_definition(I){
    check_buffer(I.buffer, content_buffer);
    let dict_url = 'http://www.dict.org/bin/Dict?Form=Dict2&Database=*&Query='+
        encodeURIComponent(
            yield I.minibuffer.read(
                $prompt = "Dict: ",
                $initial_value = I.buffer.top_frame.getSelection()));
    browser_object_follow(I.buffer, OPEN_NEW_BUFFER, dict_url);
    unfocus(I.window, I.buffer);
}
function dict_substring(I){
    check_buffer(I.buffer, content_buffer);
    let dict_url = 'http://www.dict.org/bin/Dict?Form=Dict2&Strategy=substring&Database=*&Query='+
        encodeURIComponent(
            yield I.minibuffer.read(
                $prompt = "Dict (substring): ",
                $initial_value = I.buffer.top_frame.getSelection()));
    browser_object_follow(I.buffer, OPEN_NEW_BUFFER, dict_url);
    unfocus(I.window, I.buffer);
}
function dict_Levenshtein(I){
    check_buffer(I.buffer, content_buffer);
    let dict_url = 'http://www.dict.org/bin/Dict?Form=Dict2&Strategy=lev&Database=*&Query='+
        encodeURIComponent(
            yield I.minibuffer.read(
                $prompt = "Dict (Levenshtein): ",
                $initial_value = I.buffer.top_frame.getSelection()));
    browser_object_follow(I.buffer, OPEN_NEW_BUFFER, dict_url);
    unfocus(I.window, I.buffer);
}

interactive("dict",
            "Definitions of the word from dict.org in all supported dictionaries."
            + "C-u triggers lookup for words with Levenshtein distance 1."
            + "C-u C-u triggers lookup for words which contain the given word as a substring.",
            alternates(dict_definition, dict_Levenshtein, dict_substring)
            );
define_key(default_global_keymap, "C-d", "dict");

// bind number keys to tabs
function define_switch_buffer_key (key, buf_num) {
  define_key(
    default_global_keymap, key,
    function (I) {
      switch_to_buffer(I.window, I.window.buffers.get_buffer(buf_num));
    });
}
for (let i = 0; i < 10; ++i) {
  define_switch_buffer_key(String((i+1)%10), i);
}

// The following code remembers all urls of buffers that you close during a
// session and provides the command `restore-killed-buffer-url' to reopen them.
var kill_buffer_original = kill_buffer_original || kill_buffer;

var killed_buffer_urls = [];

kill_buffer = function (buffer, force) {
    if (buffer.display_uri_string) {
        killed_buffer_urls.push(buffer.display_uri_string);
    }

    kill_buffer_original(buffer,force);
};

interactive("restore-killed-buffer-url", "Loads url from a previously killed buffer",
            function restore_killed_buffer_url (I) {
                if (killed_buffer_urls.length !== 0) {
                    var url = yield I.minibuffer.read(
                        $prompt = "Restore killed url:",
                        $completer = all_word_completer($completions = killed_buffer_urls),
                        $default_completion = killed_buffer_urls[killed_buffer_urls.length - 1],
                        $auto_complete = "url",
                        $auto_complete_initial = true,
                        $auto_complete_delay = 0,
                        $match_required);

                    load_url_in_new_buffer(url);
                } else {
                    I.window.minibuffer.message("No killed buffer urls");
                }
            });

//set the proxy server for this session only
proxy_server_default = "144.16.192.218";
proxy_port_default = 8080;

function set_proxy_session (server, port) {
  if (server === "N") {
    session_pref('network.proxy.type', 0); //direct connection
    return "Direct connection to the internet enabled for this session";
  } else {
    if (server === "") server = proxy_server_default;
    if (port === "") port = proxy_port_default;

    session_pref('network.proxy.ftp',    server);
    session_pref('network.proxy.gopher', server);
    session_pref('network.proxy.http',   server);
    session_pref('network.proxy.socks',  server);
    session_pref('network.proxy.ssl',    server);

    session_pref('network.proxy.ftp_port',    port);
    session_pref('network.proxy.gopher_port', port);
    session_pref('network.proxy.http_port',   port);
    session_pref('network.proxy.socks_port',  port);
    session_pref('network.proxy.ssl_port',    port);

    session_pref('network.proxy.share_proxy_settings', 'true');
    session_pref('network.proxy.type', 1);
    return "All protocols using "+server+":"+port+" for this session";
  }
}

// set proxy on init
set_proxy_session("", "");

function set_proxy_session_window (window, server, port) {
  var msg = set_proxy_session(server, port);
  window.minibuffer.message(msg);
}

interactive(
  "set-proxy-session-window",
  "set the proxy server for all protocols for this session only",
  function (I) {
    set_proxy_session_window(
      I.window,
      (yield I.minibuffer.read($prompt = "server ["+proxy_server_default+"] or N: ")),
      (yield I.minibuffer.read($prompt = "port ["+proxy_port_default+"]: ")));
  }
);
