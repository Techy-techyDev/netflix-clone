Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
		
		log:function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log(msg.name + ': ' + msg.message);
					} else {
						console.log.apply(console, arguments);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_error: function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
					} else {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_success: function(msg) {
			if (usi_commons.debug) {
				try {
					console.log('%c USI Success:', usi_commons.log_styles.success, msg);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		dir:function(obj) {
			if (usi_commons.debug) {
				try {
					console.dir(obj);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://app.upsellit.com",
		cdn: "https://www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			try {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null) return "";
				else return results[1];
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_script:function(source, callback, nocache) {
			try {
				if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source; //upgrade non-secure requests
				var docHead = document.getElementsByTagName("head")[0];
				if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				var usi_appender = "";
				if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations.jsp") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
					usi_appender = (source.indexOf("?")==-1?"?":"&");
					if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
					usi_appender += "si=" + usi_commons.get_sess();
				}
				newScript.src = source + usi_appender;
				if (typeof callback == "function") {
					newScript.onload = function() {
						try {
							callback();
						} catch (e) {
							usi_commons.report_error(e);
						}
					};
				}
				docHead.appendChild(newScript);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_display:function(usiQS, usiSiteID, usiKey, callback) {
			try {
				usiKey = usiKey || "";
				var source = usi_commons.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			try {
				if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
					usiKey = usiKey || "";
					var usi_append = "";
					if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
					else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
					if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
					var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
					if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
					usi_commons.last_view = usiSiteID+"_"+usiKey;
					if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
					usi_commons.load_script(source, callback);
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		remove_loads:function() {
			try {
				if (document.getElementById("usi_obj") != null) {
					document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
				}
				if (typeof(usi_commons.usi_loads) !== "undefined") {
					for (var i in usi_commons.usi_loads) {
						if (document.getElementById("usi_"+i) != null) {
							document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
						}
					}
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			try {
				if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
				usiKey = usiKey || "";
				var usi_append = "";
				if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				usi_commons.load_script(source, callback);
				if (typeof(usi_commons.usi_loads) === "undefined") {
					usi_commons.usi_loads = {};
				}
				usi_commons.usi_loads[usiSiteID] = usiSiteID;
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			try {
				var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_mail:function(qs, siteID, callback) {
			try {
				var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
					if (info.extra) queryString += info.extra + "|";
					var filetype = real_time ? "jsp" : "js";
					usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				usi_commons.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		report_error_no_console:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			try {
				if (typeof usi_cookies === 'undefined') {
					usi_commons.log_error('usi_cookies is not defined');
					return;
				}
				expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
				if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
				var value = null;
				var qsValue = usi_commons.gup(name);
				if (qsValue !== '') {
					value = qsValue;
					usi_cookies.set(name, value, expireSeconds, forceCookie);
				} else {
					value = usi_cookies.get(name);
				}
				return (value || '');
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		get_sess: function() {
			var usi_si = null;
			if (typeof(usi_cookies) === "undefined") return "";
			try {
				if (usi_cookies.get('usi_si') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_si', usi_si, 24*60*60);
					return usi_si;
				}
				if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
				usi_cookies.set('usi_si', usi_si, 24*60*60);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_si;
		},
		get_id: function(usi_append) {
			if (!usi_append) usi_append = "";
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
				usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		load_session_data: function(extended) {
			try {
				if (usi_cookies.get_json("usi_session_data") == null) {
					usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
				} else {
					usi_app.session_data = usi_cookies.get_json("usi_session_data");
					if (typeof(usi_app.session_data_callback) !== "undefined") {
						usi_app.session_data_callback();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	};
	setTimeout(function() {
		try {
			if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
			if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
				usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
			}
		} catch(err) {
			usi_commons.report_error(err);
		}
	}, 1000);
}

if (typeof usi_app === 'undefined') {
	try {
		if("undefined"==typeof usi_cookies&&(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,o,i){try{var n=-1;if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n=t.getTime()}var r=window.top||window,s=0;null!=o&&-1!=o.indexOf("=")&&(o=o.replace(new RegExp("=","g"),"USIEQLS")),null!=o&&-1!=o.indexOf(";")&&(o=o.replace(new RegExp(";","g"),"USIPRNS"));for(var a=r.name.split(";"),u="",c=0;c<a.length;c++){var l=a[c].split("=");3==l.length?(l[0]==e&&(l[1]=o,l[2]=n,s=1),null!=l[1]&&"null"!=l[1]&&(u+=l[0]+"="+l[1]+"="+l[2]+";")):""!=a[c]&&(u+=a[c]+";")}0==s&&(u+=e+"="+o+"="+n+";"),r.name=u}catch(e){}},flush_window_name:function(e){try{for(var o=window.top||window,i=o.name.split(";"),n="",t=0;t<i.length;t++){var r=i[t].split("=");3==r.length&&(0==r[0].indexOf(e)||(n+=i[t]+";"))}o.name=n}catch(e){}},get_from_window_name:function(e){try{for(var o,i=(window.top||window).name.split(";"),n=0;n<i.length;n++){var t=i[n].split("=");if(3==t.length){if(t[0]==e&&(-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),!("-1"!=t[2]&&usi_cookies.datediff(t[2])<0)))return[o,t[2]]}else if(2==t.length&&t[0]==e)return-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),[o,(new Date).getTime()+6048e5]}}catch(e){}return null},datediff:function(e){return e-(new Date).getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),o=e[e.length-1];if("com"==o||"net"==o||"org"==o||"us"==o||"co"==o||"ca"==o)return e[e.length-2]+"."+e[e.length-1]}catch(e){}return document.domain},create_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(o)+n+"; path=/;domain="+s+"; "+r}},create_nonencoded_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+o+n+"; path=/;domain="+s+"; "+r}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var o=e+"=",i=[];try{i=document.cookie.split(";")}catch(e){}for(var n=0;n<i.length;n++){for(var t=i[n];" "==t.charAt(0);)t=t.substring(1,t.length);if(0==t.indexOf(o))return decodeURIComponent(t.substring(o.length,t.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(e){}},get_ls:function(e){try{var o=localStorage.getItem(e);if(null!=o){if(0==o.indexOf("{")&&-1!=o.indexOf("usi_expires")){var i=JSON.parse(o);if((new Date).getTime()>i.usi_expires)return localStorage.removeItem(e),null;o=i.value}return decodeURIComponent(o)}}catch(e){}return null},get:function(e){var o=usi_cookies.read_cookie(e);if(null!=o)return o;try{if(null!=localStorage&&null!=(o=usi_cookies.get_ls(e)))return o;if(null!=sessionStorage&&null!=(o=sessionStorage.getItem(e)))return decodeURIComponent(o)}catch(e){}var i=usi_cookies.get_from_window_name(e);if(null!=i&&i.length>1)try{o=decodeURIComponent(i[0])}catch(e){return i[0]}return o},get_json:function(e){var o=null,i=usi_cookies.get(e);if(null==i)return null;try{o=JSON.parse(i)}catch(e){i=i.replace(/\\"/g,'"');try{o=JSON.parse(JSON.parse(i))}catch(e){try{o=JSON.parse(i)}catch(e){}}}return o},search_cookies:function(e){e=e||"";var o=[];return document.cookie.split(";").forEach((function(i){var n=i.split("=")[0].trim();""!==e&&0!==n.indexOf(e)||o.push(n)})),o},set:function(e,o,i,n){"undefined"!=typeof usi_nevercookie&&(n=!1),void 0===i&&(i=-1);try{o=o.replace(/(\r\n|\n|\r)/gm,"")}catch(e){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",o+"",i);try{if(i>0&&null!=localStorage){var t={value:o,usi_expires:(new Date).getTime()+1e3*i};localStorage.setItem(e,JSON.stringify(t))}else null!=sessionStorage&&sessionStorage.setItem(e,o)}catch(e){}if(n||null==o){if(null!=o){if(null==usi_cookies.read_cookie(e))if(!n)if(usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count)return void usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);if(o.length>usi_cookies.max_cookie_length)return void usi_cookies.report_error('Cookie "'+e+'" truncated ('+o.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length)}usi_cookies.create_cookie(e,o,i)}},set_json:function(e,o,i,n){var t=JSON.stringify(o).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,t,i,n)},flush:function(e){e=e||"usi_";var o,i,n,t=document.cookie.split(";");for(o=0;o<t.length;o++)0==(i=t[o]).trim().toLowerCase().indexOf(e)&&(n=i.trim().split("=")[0],usi_cookies.del(n));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&localStorage.removeItem(r);if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&sessionStorage.removeItem(r)}catch(e){}},print:function(){for(var e=document.cookie.split(";"),o="",i=0;i<e.length;i++){var n=e[i];0==n.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(n.trim())+" (cookie)"),o+=","+n.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var t in localStorage)0==t.indexOf("usi_")&&"string"==typeof localStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+usi_cookies.get_ls(t)+" (localStorage)"),o+=","+t+",");if(null!=sessionStorage)for(var t in sessionStorage)0==t.indexOf("usi_")&&"string"==typeof sessionStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+sessionStorage[t]+" (sessionStorage)"),o+=","+t+",")}catch(e){}for(var r=(window.top||window).name.split(";"),s=0;s<r.length;s++){var a=r[s].split("=");if(3==a.length&&0==a[0].indexOf("usi_")&&-1==o.indexOf(","+a[0]+",")){var u=a[1];-1!=u.indexOf("USIEQLS")&&(u=u.replace(new RegExp("USIEQLS","g"),"=")),-1!=u.indexOf("USIPRNS")&&(u=u.replace(new RegExp("USIPRNS","g"),";")),console.log(a[0]+"="+u+" (window.name)"),o+=","+n.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,o;for(e=0;e<arguments.length;e++)if(""===(o=usi_cookies.get(arguments[e]))||null===o||"null"===o||"undefined"===o)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie))try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&(usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?usi_email_id_fix="+encodeURIComponent(usi_cookies.get_from_window_name("usi_email_id")[0])),usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-(new Date).getTime())/1e3,!0)),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}
"undefined"==typeof usi_dom&&(usi_dom={},usi_dom.get_elements=function(e,t){return t=t||document,Array.prototype.slice.call(t.querySelectorAll(e))},usi_dom.count_elements=function(e,t){return t=t||document,usi_dom.get_elements(e,t).length},usi_dom.get_nth_element=function(e,t,n){var o=null;n=n||document;var r=usi_dom.get_elements(t,n);return r.length>=e&&(o=r[e-1]),o},usi_dom.get_first_element=function(e,t){if(""===(e||""))return null;if(t=t||document,"[object Array]"===Object.prototype.toString.call(e)){for(var n=null,o=0;o<e.length;o++){var r=e[o];if(null!=(n=usi_dom.get_first_element(r,t)))break}return n}return t.querySelector(e)},usi_dom.get_element_text_no_children=function(e,t){var n="";if(null==t&&(t=!1),null!=(e=e||document)&&null!=e.childNodes)for(var o=0;o<e.childNodes.length;++o)3===e.childNodes[o].nodeType&&(n+=e.childNodes[o].textContent);return!0===t&&(n=usi_dom.clean_string(n)),n.trim()},usi_dom.clean_string=function(e){if("string"==typeof e){return(e=(e=(e=(e=(e=(e=(e=e.replace(/[\u2010-\u2015\u2043]/g,"-")).replace(/[\u2018-\u201B]/g,"'")).replace(/[\u201C-\u201F]/g,'"')).replace(/\u2024/g,".")).replace(/\u2025/g,"..")).replace(/\u2026/g,"...")).replace(/\u2044/g,"/")).replace(/[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g,"").trim()}},usi_dom.encode=function(e){if("string"==typeof e){var t=encodeURIComponent(e);return t=t.replace(/[-_.!~*'()]/g,function(e){return"%"+e.charCodeAt(0).toString(16).toUpperCase()})}},usi_dom.get_closest=function(e,t){for(e=e||document,"function"!=typeof Element.prototype.matches&&(Element.prototype.matches=Element.prototype.matchesSelector||Element.prototype.mozMatchesSelector||Element.prototype.msMatchesSelector||Element.prototype.oMatchesSelector||Element.prototype.webkitMatchesSelector||function(e){for(var t=(this.document||this.ownerDocument).querySelectorAll(e),n=t.length;--n>=0&&t.item(n)!==this;);return n>-1});null!=e&&e!==document;e=e.parentNode)if(e.matches(t))return e;return null},usi_dom.get_classes=function(e){var t=[];return null!=e&&null!=e.classList&&(t=Array.prototype.slice.call(e.classList)),t},usi_dom.add_class=function(e,t){if(null!=e){var n=usi_dom.get_classes(e);-1===n.indexOf(t)&&(n.push(t),e.className=n.join(" "))}},usi_dom.string_to_decimal=function(e){var t=null;if("string"==typeof e)try{var n=parseFloat(e.replace(/[^0-9\.-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.string_to_integer=function(e){var t=null;if("string"==typeof e)try{var n=parseInt(e.replace(/[^0-9-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.get_currency_string_from_content=function(e){if("string"!=typeof e)return"";try{e=e.trim();var t=e.match(/^([^\$]*?)(\$(?:[\,\,]?\d{1,3})+(?:\.\d{2})?)(.*?)$/)||[];return 4===t.length?t[2]:""}catch(e){return usi_commons.log("Error: "+e.message),""}},usi_dom.get_absolute_url=function(){var e;return function(t){return(e=e||document.createElement("a")).href=t,e.href}}(),usi_dom.format_number=function(e,t){var n="";if("number"==typeof e){t=t||0;var o=e.toFixed(t).split(/\./g);if(1==o.length||2==o.length)n=o[0].replace(/./g,function(e,t,n){return t&&"."!==e&&(n.length-t)%3==0?","+e:e}),2==o.length&&(n+="."+o[1])}return n},usi_dom.format_currency=function(e,t,n){var o="";return e=Number(e),!1===isNaN(e)&&("object"==typeof Intl&&"function"==typeof Intl.NumberFormat?(t=t||"en-US",n=n||{style:"currency",currency:"USD"},o=e.toLocaleString(t,n)):o=e),o},usi_dom.to_decimal_places=function(e,t){if(null!=e&&"number"==typeof e&&null!=t&&"number"==typeof t){if(0==t)return parseFloat(Math.round(e));for(var n=10,o=1;o<t;o++)n*=10;return parseFloat(Math.round(e*n)/n)}return null},usi_dom.trim_string=function(e,t,n){return n=n||"",(e=e||"").length>t&&(e=e.substring(0,t),""!==n&&(e+=n)),e},usi_dom.attach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);usi_dom.detach_event(e,t,o),o.addEventListener?o.addEventListener(e,t,!1):o.attachEvent("on"+e,t)},usi_dom.detach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);o.removeEventListener?o.removeEventListener(e,t,!1):o.detachEvent("on"+e,t)},usi_dom.find_supported_element=function(e,t){return(t=t||document)===window?window:!0===usi_dom.is_event_supported(e,t)?t:t===document?window:usi_dom.find_supported_element(e,document)},usi_dom.is_event_supported=function(e,t){return null!=t&&void 0!==t["on"+e]},usi_dom.is_defined=function(e,t){if(null==e)return!1;if(""===(t||""))return!1;var n=!0,o=e;return t.split(".").forEach(function(e){!0===n&&(null==o||"object"!=typeof o||!1===o.hasOwnProperty(e)?n=!1:o=o[e])}),n},usi_dom.observe=function(e,t,n){var o=location.href,r=window.MutationObserver||window.WebkitMutationObserver;return t=t||{onUrlUpdate:!1,observerOptions:{childList:!0,subtree:!0}},function(e,n){var i=null,u=function(){var e=location.href;t.onUrlUpdate&&e!==o?(n(),o=e):n()};return r?(i=new r(function(e){var r=location.href,i=e[0].addedNodes.length||e[0].removedNodes.length;i&&t.onUrlUpdate&&r!==o?(n(),o=r):i&&n()})).observe(e,t.observerOptions):window.addEventListener&&(e.addEventListener("DOMNodeInserted",u,!1),e.addEventListener("DOMNodeRemoved",u,!1)),i}}(),usi_dom.params_to_object=function(e){var t={};""!=(e||"")&&e.split("&").forEach(function(e){var n=e.split("=");2===n.length?t[decodeURIComponent(n[0])]=decodeURIComponent(n[1]):1===n.length&&(t[decodeURIComponent(n[0])]=null)});return t},usi_dom.object_to_params=function(e){var t=[];if(null!=e)for(var n in e)!0===e.hasOwnProperty(n)&&t.push(encodeURIComponent(n)+"="+(null==e[n]?"":encodeURIComponent(e[n])));return t.join("&")},usi_dom.interval_with_timeout=function(e,t,n,o){if("function"!=typeof e)throw new Error("usi_dom.interval_with_timeout(): iterationFunction must be a function");if(null==t)t=function(e){return e};else if("function"!=typeof t)throw new Error("usi_dom.interval_with_timeout(): timeoutCallback must be a function");if(null==n)n=function(e){return e};else if("function"!=typeof n)throw new Error("usi_dom.interval_with_timeout(): completeCallback must be a function");var r=(o=o||{}).intervalMS||20,i=o.timeoutMS||2e3;if("number"!=typeof r)throw new Error("usi_dom.interval_with_timeout(): intervalMS must be a number");if("number"!=typeof i)throw new Error("usi_dom.interval_with_timeout(): timeoutMS must be a number");var u=!1,l=new Date,a=setInterval(function(){var o=new Date-l;if(o>=i)return clearInterval(a),t({elapsedMS:o});!1===u&&(u=!0,e(function(e,t){if(u=!1,!0===e)return clearInterval(a),(t=t||{}).elapsedMS=new Date-l,n(t)}))},r)},usi_dom.load_external_stylesheet=function(e,t,n){if(""!==(e||"")){""===(t||"")&&(t="usi_stylesheet_"+(new Date).getTime());var o={url:e,id:t},r=document.getElementsByTagName("head")[0];if(null!=r){var i=document.createElement("link");i.type="text/css",i.rel="stylesheet",i.id=o.id,i.href=e,usi_dom.attach_event("load",function(){if(null!=n)return n(null,o)},i),r.appendChild(i)}}else if(null!=n)return n(null,o)},usi_dom.ready=function(e){void 0!==document.readyState&&"complete"===document.readyState?e():window.addEventListener?window.addEventListener("load",e,!0):window.attachEvent?window.attachEvent("onload",e):setTimeout(e,5e3)},usi_dom.fit_text=function(e,t){t||(t={});var n={multiLine:!0,minFontSize:.1,maxFontSize:20,widthOnly:!1},o={};for(var r in n)t.hasOwnProperty(r)?o[r]=t[r]:o[r]=n[r];var i=Object.prototype.toString.call(e);function u(e,t){var n,o,r,i,u,l,a,s;r=e.innerHTML,u=parseInt(window.getComputedStyle(e,null).getPropertyValue("font-size"),10),i=function(e){var t=window.getComputedStyle(e,null);return(e.clientWidth-parseInt(t.getPropertyValue("padding-left"),10)-parseInt(t.getPropertyValue("padding-right"),10))/u}(e),o=function(e){var t=window.getComputedStyle(e,null);return(e.clientHeight-parseInt(t.getPropertyValue("padding-top"),10)-parseInt(t.getPropertyValue("padding-bottom"),10))/u}(e),i&&(t.widthOnly||o)||(t.widthOnly?usi_commons.log("Set a static width on the target element "+e.outerHTML):usi_commons.log("Set a static height and width on the target element "+e.outerHTML)),-1===r.indexOf("textFitted")?((n=document.createElement("span")).className="textFitted",n.style.display="inline-block",n.innerHTML=r,e.innerHTML="",e.appendChild(n)):n=e.querySelector("span.textFitted"),t.multiLine||(e.style["white-space"]="nowrap"),l=t.minFontSize,s=t.maxFontSize;for(var c=l,d=1e3;l<=s&&d>0;)d--,a=s+l-.1,n.style.fontSize=a+"em",n.scrollWidth/u<=i&&(t.widthOnly||n.scrollHeight/u<=o)?(c=a,l=a+.1):s=a-.1;n.style.fontSize!==c+"em"&&(n.style.fontSize=c+"em")}"[object Array]"!==i&&"[object NodeList]"!==i&&"[object HTMLCollection]"!==i&&(e=[e]);for(var l=0;l<e.length;l++)u(e[l],o)});
'undefined'==typeof usi_url&&(usi_url={},usi_url.URL=function(a){a=a||location.href;var b=document.createElement('a');if(b.href=a,this.full=b.href||'',this.protocol=(b.protocol||'').split(':')[0],this.host=b.host||'',-1!=this.host.indexOf(':')&&(this.host=this.host.substring(0,this.host.indexOf(':'))),this.port=b.port||'',this.hash=b.hash||'',this.baseURL='',this.tld='',this.domain='',this.subdomain='',this.domain_tld='',''!==this.protocol&&''!==this.host){this.baseURL=this.protocol+'://'+this.host+'/';var c=this.host.split(/\./g);if(2<=c.length){if(-1<['co','com','org','net','int','edu','gov','mil'].indexOf(c[c.length-2])&&2===c[c.length-1].length){var d=c.pop(),e=c.pop();this.tld=e+'.'+d}else this.tld=c.pop()}0<c.length&&(this.domain=c.pop(),0<c.length&&(this.subdomain=c.join('.'))),this.domain_tld=this.domain+'.'+this.tld}var f=b.pathname||'';0!==f.indexOf('/')&&(f='/'+f),this.path=new usi_url.Path(f),this.params=new usi_url.Params((b.search||'').substr(1))},usi_url.URL.prototype.build=function(a,b,c){var d='';return''!==this.protocol&&''!==this.host&&(null==a&&(a=!0),null==b&&(b=!0),null==c&&(c=!0),!0==a&&(d+=this.protocol+':'),d+='//'+this.host,''!==this.port&&(d+=':'+this.port),!0==b&&(d+=this.path.full,!0==c&&0<Object.keys(this.params.parameters).length&&(d+='?',d+=this.params.build()))),d},usi_url.Path=function(a){a=a||'',this.full=a,this.directories=[],this.filename='';for(var b=a.substr(1).split(/\//g);0<b.length;)1===b.length?this.filename=b.shift():this.directories.push(b.shift());this.has_directory=function(a){return-1<this.directories.indexOf(a)},this.contains=function(a){return-1<this.full.indexOf(a)}},usi_url.Params=function(a){a=a||'',this.full=a,this.parameters=function(a){var b={};if(1===a.length&&''===a[0])return b;for(var c,d,e,f=0;f<a.length;f++)if(e=a[f].split('='),c=e[0]&&e[0].replace(/\+/g,' '),d=e[1]&&e[1].replace(/\+/g,' '),1===e.length)b[c]='';else try{b[c]=decodeURIComponent(d)}catch(a){b[c]=d}return b}(a.split('&')),this.count=Object.keys(this.parameters).length,this.get=function(a){return a in this.parameters?this.parameters[a]:null},this.has=function(a){return a in this.parameters},this.set=function(a,b){this.parameters[a]=b,this.count=Object.keys(this.parameters).length},this.remove=function(a){!0===this.has(a)&&delete this.parameters[a],this.count=Object.keys(this.parameters).length},this.build=function(){var a=this,b=[];for(var c in a.parameters)!0===a.parameters.hasOwnProperty(c)&&b.push(c+'='+encodeURIComponent(a.parameters[c]));return b.join('&')},this.remove_usi_params=function(a){var b=this;for(var c in a=a||[],-1===a.indexOf('usi_')&&a.push('usi_'),b.parameters)if(!0===b.parameters.hasOwnProperty(c)){var d=!1;a.forEach(function(a){0===c.indexOf(a)&&(d=!0)}),d&&b.remove(c)}},this.remove_all=function(){var a=this;for(var b in a.parameters)!0===a.parameters.hasOwnProperty(b)&&a.remove(b)}});
"undefined"==typeof usi_ajax&&(usi_ajax={},usi_ajax.get=function(e,t){try{return usi_ajax.get_with_options({url:e},t)}catch(e){usi_commons.report_error(e)}},usi_ajax.get_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("GET",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.post=function(e,t,r){try{return usi_ajax.post_with_options({url:e,params:t},r)}catch(e){usi_commons.report_error(e)}},usi_ajax.post_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],e.paramsDataType=e.paramsDataType||"string",e.params=e.params||"",null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("POST",e.url,!0),"formData"===e.paramsDataType||("object"===e.paramsDataType?(a.setRequestHeader("Content-type","application/json; charset=utf-8"),e.params=JSON.stringify(e.params)):a.setRequestHeader("Content-type","application/x-www-form-urlencoded")),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"",r.responseURL=a.responseURL||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send(e.params)}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.form_post=function(e,t,r){try{r=r||"post";var a=document.createElement("form");a.setAttribute("method",r),a.setAttribute("action",e),null!=t&&"object"==typeof t&&Object.keys(t).forEach(function(e){var r=document.createElement("input");r.setAttribute("type","hidden"),r.setAttribute("name",e),r.setAttribute("value",t[e]),a.appendChild(r)}),document.body.appendChild(a),a.submit()}catch(e){usi_commons.report_error(e)}},usi_ajax.put_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("PUT",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.get_with_script=function(e,t,r){try{var a={};null==t&&(t=!0);var n="usi_"+(new Date).getTime(),s=document.getElementsByTagName("head")[0];top.location!=location&&(s=parent.document.getElementsByTagName("head")[0]);var o=document.createElement("script");o.id=n,o.type="text/javascript",o.src=e,o.addEventListener("load",function(){if(!0===t&&s.removeChild(o),null!=r)return r(null,a)}),s.appendChild(o)}catch(e){usi_commons.report_error(e)}},usi_ajax.listener=function(e){if(null==e&&(e=!1),null!=XMLHttpRequest){var t=this;t.ajax=new Object,t.clear=function(){t.ajax.requests=[],t.ajax.registeredRequests=[],t.ajax.scriptLoads=[],t.ajax.registeredScriptLoads=[]},t.clear(),t.register=function(e,r,a){try{var n={method:e=(e||"*").toUpperCase(),url:r=r||"*",callback:a=a||function(){}};t.ajax.registeredRequests.push(n)}catch(e){usi_commons.report_error(e)}},t.registerScriptLoad=function(e,r){try{var a={url:e=e||"*",callback:r=r||function(){}};t.ajax.registeredScriptLoads.push(a)}catch(e){usi_commons.report_error(e)}},t.registerFormSubmit=function(t,r){try{null!=t&&usi_dom.attach_event("submit",function(a){if(!0===e&&usi_commons.log("USI AJAX: form submit"),null!=a&&!0===a.returnValue){a.preventDefault();var n={action:t.action,data:{},e:a},s=["submit"];if(Array.prototype.slice.call(t.elements).forEach(function(e){try{-1===s.indexOf(e.type)&&("checkbox"===e.type?!0===e.checked&&(n.data[e.name]=e.value):n.data[e.name]=e.value)}catch(e){usi_commons.report_error(e)}}),null!=r)return r(null,n);a.returnValue=!0}},t)}catch(e){usi_commons.report_error(e)}},t.listen=function(){try{t.ajax.originalOpen=XMLHttpRequest.prototype.open,t.ajax.originalSend=XMLHttpRequest.prototype.send,XMLHttpRequest.prototype.open=function(r,a){r=(r||"").toUpperCase(),a=a||"",a=usi_dom.get_absolute_url(a),!0===e&&usi_commons.log("USI AJAX: open["+r+"]: "+a);var n={method:r,url:a,openDate:new Date};t.ajax.requests.push(n);var s=null;t.ajax.registeredRequests.forEach(function(e){e.method!=r&&"*"!=e.method||(a.indexOf(e.url)>-1||"*"==e.url)&&(s=e)}),null!=s&&(!0===e&&usi_commons.log("USI AJAX: Registered URL["+r+"]: "+a),this.requestObj=n,this.requestObj.callback=s.callback),t.ajax.originalOpen.apply(this,arguments)},XMLHttpRequest.prototype.send=function(r){var a=this;null!=a.requestObj&&(!0===e&&usi_commons.log("USI AJAX: Send Registered URL["+a.requestObj.method+"]: "+a.requestObj.url),""!=(r||"")&&(a.requestObj.params=r),a.addEventListener?a.addEventListener("readystatechange",function(){t.ajax.readyStateChanged(a)},!1):t.ajax.proxifyOnReadyStateChange(a)),t.ajax.originalSend.apply(a,arguments)},t.ajax.readyStateChanged=function(t){if(4===t.readyState&&null!=t.requestObj&&(t.requestObj.completedDate=new Date,!0===e&&usi_commons.log("Completed: "+t.requestObj.url),null!=t.requestObj.callback)){var r={requestObj:t.requestObj,responseText:t.responseText};return t.requestObj.callback(null,r)}},t.ajax.proxifyOnReadyStateChange=function(e){var r=e.onreadystatechange;null!=r&&(e.onreadystatechange=function(){t.ajax.readyStateChanged(e),r()})},document.head.addEventListener("load",function(e){if(null!=e&&null!=e.target&&""!=(e.target.src||"")){var r=e.target.src,a={url:r=usi_dom.get_absolute_url(r),completedDate:new Date};t.ajax.scriptLoads.push(a);var n=null;if(t.ajax.registeredScriptLoads.forEach(function(e){(r.indexOf(e.url)>-1||"*"==e.url)&&(n=e)}),null!=n&&null!=n.callback)return n.callback(null,a)}},!0),usi_commons.log("USI AJAX: listening ...")}catch(e){usi_commons.report_error(e),usi_commons.log("usi_ajax.listener ERROR: "+e.message)}},t.unregisterAll=function(){t.ajax.registeredRequests=[],t.ajax.registeredScriptLoads=[]}}});

if (typeof usi_analytics === 'undefined') {
	usi_analytics = {
		cookie_length : 30,
		load_script:function(source) {
			var docHead = document.getElementsByTagName("head")[0];
			if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			docHead.appendChild(newScript);
		},
		get_id:function() {
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_analytics') == null && usi_cookies.get('usi_id') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_analytics') != null) usi_id = usi_cookies.get('usi_analytics');
				if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
				usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		send_page_hit:function(report_type, companyID, data1) {
			var qs = "";
			if (data1) qs += data1;
			usi_analytics.load_script(usi_commons.domain + "/analytics/hit.js?usi_a="+usi_analytics.get_id(companyID)+"&usi_t="+(Date.now())+"&usi_r="+report_type+"&usi_c="+companyID+qs+"&usi_u="+encodeURIComponent(location.href));
		}
	};
}
		usi_cookieless = true;
		usi_app = {};
		usi_commons.domain = usi_commons.cdn;
		usi_app.main = function () {
			try { // General
				usi_commons.log("usi_app.main()")
				usi_app.url = new usi_url.URL(location.href.toLowerCase());
				usi_app.url_href = location.href.toLowerCase();
				usi_app.coupon = usi_cookies.value_exists("usi_coupon_applied") ? "" : usi_commons.gup_or_get_cookie("usi_coupon", usi_cookies.expire_time.week, true);
				usi_app.force_group = usi_commons.gup_or_get_cookie('usi_force_group');
				usi_app.force_version = usi_commons.gup_or_get_cookie('usi_force_version');

				// Pages
				usi_app.is_create_account_page = location.href.indexOf("/users/new") != -1;
				usi_app.has_flex_account_page = usi_app.url_href.indexOf("freetrialflex10") != -1;
				usi_app.is_cart_page = usi_app.url_href.match("/cart") != null;
				usi_app.is_checkout_page = usi_app.url_href.match("/purchase") != null;
				usi_app.is_confirmation_page = location.href.indexOf("/purchase/success") != -1;
				usi_app.is_video_page = usi_app.is_video();
				usi_app.is_image_page = usi_app.is_image();
				usi_app.is_music_page = usi_app.is_music();
				usi_app.price_cart = null;

				if (usi_app.is_video_page) {
					usi_cookies.set("usi_most_recent", "footage");
				} else if (usi_app.is_image_page) {
					usi_cookies.set("usi_most_recent", "image");
				} else if (usi_app.is_music_page) {
					usi_cookies.set("usi_most_recent", "music");
				}

				if (usi_cookies.get("usi_most_recent") === "image" && usi_app.is_checkout_page) {
					usi_cookies.set("usi_cart_contains_image", "true", 24 * 60 * 60, true);
				}

				usi_app.creative_flow_pages = [
					"/creative-flow",
					"/create",
					"/catalog",
					"/predict",
					"/planning",
					"/explore/photo-editor",
					"/explore/background-remover",
					"/explore/collage-maker",
					"/explore/crop-images",
					"/image-resizer",
					"/colors",
					"/file-converter"
				];

				usi_app.flex_pricing_page = [
						"/pricing",
						"/pricing/music",
						"/pricing/video"
				];

				usi_app.is_discover_page = location.href.toLowerCase().match("/10-free-stock-images/") != null;
				usi_app.is_creative_flow_page = usi_app.creative_flow_pages.indexOf(usi_app.url.path.full) > -1 ? 1 : 0;
				usi_app.is_flex_pricing_page = usi_app.flex_pricing_page.indexOf(usi_app.url.path.full) > -1 ? 1 : 0;

				// Booleans
				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.day, true) != "";
				usi_app.is_existing_customer = usi_app.check_existing_customer();
				usi_app.is_suppressed = location.href.indexOf("qa.shutterstock.com") != -1; /*|| !usi_app.is_video()*/
				usi_app.user_status = usi_app.get_user_status("user").isActive;
				usi_app.is_flex_account_page = usi_app.check_flex_account_page();

				usi_app.is_footage_in_cart = usi_commons.gup_or_get_cookie("usi_cart_contains_footage", usi_cookies.expire_time.day, true) != "";
				usi_app.is_music_in_cart = usi_commons.gup_or_get_cookie("usi_cart_contains_music", usi_cookies.expire_time.day, true) != "";
				usi_app.is_image_in_cart = usi_commons.gup_or_get_cookie("usi_cart_contains_image", usi_cookies.expire_time.day, true) != "";
				usi_app.check_language_site();
				usi_app.can_flex = usi_app.flex_lang_check();

				// Attempt to break out of iframe
				if (window !== window.parent) {
					return usi_commons.load_script("https://www.upsellit.com/active/shutterstock.jsp", null, true);
				}

				if (usi_app.is_cart_page) {
					usi_app.save_cart();
				} else if (usi_app.is_checkout_page) {
					usi_app.scrape_subtotal();
				}

				if (usi_app.is_existing_customer) {
					//No existing customers
					return;
				}

				if (usi_commons.gup("utm_campaign") == "Upsellit.com") {
					usi_app.set_utms();
				}
				if (usi_commons.gup("irclickid") != "" && (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null)) {
					usi_cookies.del("usi_clicked_1");
					var date_now = Date.now().toString();
					var cookie_value = date_now + "|-1|" + date_now + "|" + usi_commons.gup("irclickid") + "|";
					usi_cookies.create_nonencoded_cookie("IR_1305", cookie_value, 30 * 24 * 60 * 60, true);
					usi_cookies.create_nonencoded_cookie("irclickid", usi_commons.gup("irclickid"), 30 * 24 * 60 * 60, true);
				}

				// check suppressions
				if (usi_app.is_suppressed) {
					usi_commons.log("Company is suppressed");
					return;
				}

				if (usi_app.coupon != "" && usi_app.is_checkout_page) {
					usi_app.boostbar.load();
					setTimeout(function () {
						usi_app.apply_coupon();
					}, 3000);
				} else if (!usi_app.is_create_account_page && !usi_app.is_cart_page && !usi_app.is_checkout_page) {
					setTimeout(function () {
						usi_app.listen_for_active_cart();
					}, 1000);
				}

				if(!usi_app.is_cart_page && !usi_app.is_checkout_page){
					usi_app.get_ajax_cart();
					// Listen for add to cart
					usi_app.post_listen("https://www.shutterstock.com/napi/cart/relationships/items?application-namespace=sstk_cart", usi_app.handle_ajax_response2);
				}

				usi_app.load();

			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.listen_for_active_cart = function() {
			usi_commons.log('usi_app.listen_for_active_cart()');
			try {
				if (usi_app.is_cart_page) {
					if (document.querySelector("div[data-automation='CartBasket_itemsList_div']") != null) {
						if (document.querySelector("div[data-automation='CartBasket_itemsList_div']").textContent != "") {
							usi_cookies.set("usi_active_cart", "true", 24*60*60, true);
							usi_app.load();
							return;
						}
					}
				} else {
					if (document.querySelector('.MuiBadge-badge.MuiBadge-anchorOriginTopRightCircular.MuiBadge-colorPrimary') != null) {
						var is_active_cart = false;
						var cart_count = Number(document.querySelector('.MuiBadge-badge.MuiBadge-anchorOriginTopRightCircular.MuiBadge-colorPrimary').textContent);
						if (cart_count > 0) {
							is_active_cart = true;
						} else if (document.querySelector('.MuiSnackbar-root .MuiAlert-filledSuccess') != null) {
							is_active_cart = true;
						}
						if (is_active_cart) {
							usi_app.is_active_cart = true;
							usi_cookies.set("usi_active_cart", "true", 24 * 60 * 60, true);
							if (usi_app.is_video_page && !usi_cookies.value_exists("usi_cart_contains_footage")) {
								usi_cookies.set("usi_cart_contains_footage", "true", 24 * 60 * 60, true);
								usi_app.is_footage_in_cart = true;
								usi_app.load();
								return;
							} else if (usi_app.is_music_page && !usi_cookies.value_exists("usi_cart_contains_music")) {
								usi_cookies.set("usi_cart_contains_music", "true", 24 * 60 * 60, true);
								usi_app.is_music_in_cart = true;
								usi_app.load();
								return;
							}
						}
					}
				}
				setTimeout(usi_app.listen_for_active_cart, 2000);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.check_existing_customer = function() {
			try {
				//if (usi_cookies.value_exists("usi_existing_customer")) return true;
				if (window.dataLayer != undefined) {
					for (var i = 0; i < window.dataLayer.length; i++) {
						if (window.dataLayer[i]['user'] != undefined) {
							if (dataLayer[i].user.isActive == 'true' || dataLayer[i].user.status == 'customer') {
								//usi_cookies.set("usi_existing_customer", "1", 604800, true);
								return true;
							}
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false; // new customer
		};

		usi_app.set_utms = function() {
			try {
				var usi_ga = ga && ga.getAll();
				var usi_gtm = usi_ga && usi_ga[0].get('name');
				ga(usi_gtm + '.set', 'campaignName', usi_commons.gup("utm_campaign"));
				ga(usi_gtm + '.set', 'campaignSource', usi_commons.gup("utm_source"));
				ga(usi_gtm + '.set', 'campaignMedium', usi_commons.gup("utm_medium"));
				ga(usi_gtm + '.send', 'pageview');
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.flex_lang_check = function() {
			if(usi_app.is_hindi_language || usi_app.is_tamil_language || usi_app.is_targus_site || usi_app.is_marathi_language){
				return false
			}else{
				return true
			}
		};

		usi_app.load = function () {
			usi_commons.log("usi_app.load()");
			try {
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}

				if(usi_app.is_creative_flow_page){
					usi_commons.log('USI Creative Flow Page Load');
				}

				if(!usi_app.is_flex_pricing_page) {
						if (usi_app.is_flex_account_page) {
							usi_commons.log('Is Flex Account Create Page');
							usi_commons.load_precapture("NH7KffuvEx7CJuogK2t2pgG", "45145");
						}

						if (usi_app.is_image() || usi_app.is_image_in_cart) {
							//********* Images areas
							var language_key = usi_app.get_language_key();
							if (usi_app.check_sub_total_price(49)) {
								//Flex Trial
								usi_app.messaging = usi_app.get_messaging("images_tenpercent");
								var split_key = usi_app.get_split_key("new", "new", false);
								if (split_key == 'current') {
									usi_commons.log('[ load ] * * * Load Images Flex Trial Current [language key: ' + language_key + '] * * *');
									usi_commons.load_view("uBrADIz5F0XpO6ujvavcLhd", "45049", usi_commons.device + language_key);
								} else {
									usi_commons.log('[ load ] * * * Load Images Flex Trial New [language key: ' + language_key + '] * * *');
									usi_commons.load_view("EEyuhZZUBMcCoN5ZQRaEqpf", "45123", usi_commons.device + language_key);
								}
							} else {
								// Images 10% Off
								usi_app.messaging = usi_app.get_messaging("images_tenpercent");
								usi_commons.log('[ load ] * * * Load Images 10% TT [language key: ' + language_key + '] * * *');
								usi_commons.load_view("DTg6UC26TOUKja7Xm7SQEE8", "44543", usi_commons.device + language_key);
							}


						} else if (usi_app.is_video_page || usi_app.is_footage_in_cart) {
							//********* Footage / Video Area
							var language_key = usi_app.get_language_key();
							if (usi_cookies.value_exists("usi_subtotal")) {
								//Cart
								if (usi_app.check_sub_total_price(79)) {
									//Flex Trial - Cart
									var split_key = usi_app.get_split_key("new", "new", false);
									if (split_key == 'current') {
										usi_commons.log('[ load ] * * * Load Video Flex Trial Current [language key: ' + language_key + '] * * *');
										usi_commons.load_view("DtqqNh87nUlpmESmLuq4VXg", "45055", usi_commons.device + language_key);
									} else {

										usi_commons.log('[ load ] * * * Load Video Flex Trial New [language key: ' + language_key + '] * * *');
										usi_commons.load_view("HyPDhKl6fNqdCmNPpnuE1eh", "45127", usi_commons.device + language_key);
									}

								} else {
									//Non Flex - Cart Only
									usi_commons.log('[ load ] * * * Load Dynamic Cart [language: ' + language_key + '] * * *');
									usi_app.messaging = usi_app.get_messaging("footage_tenpercent");
									if (Math.random() > .5) {
										//Static - Cart Only
										usi_commons.load_view("OhILFtSy8Qbac2GrMy7JW0B", "44237", usi_commons.device + language_key);
									} else {
										//Video - Cart Only
										usi_commons.load_view("3sdTmnXj6xyOmMM7Oi0PmxA", "44233", usi_commons.device + language_key);
									}
								}
							} else {
								//Non Cart
								if (usi_app.check_sub_total_price(79)) {
									//Flex Trial - Non Cart
									var split_key = usi_app.get_split_key("new", "new", false);
									if (split_key == 'current') {
										usi_commons.log('[ load ] * * * Load Video Flex Trial Current [language key: ' + language_key + '] * * *');
										usi_commons.load_view("DtqqNh87nUlpmESmLuq4VXg", "45055", usi_commons.device + language_key);
									} else {
										usi_commons.log('[ load ] * * * Load Video Flex Trial New [language key: ' + language_key + '] * * *');
										usi_commons.load_view("HyPDhKl6fNqdCmNPpnuE1eh", "45127", usi_commons.device + language_key);
									}
								} else {
									//Non Flex - Non Cart
									usi_app.messaging = usi_app.get_messaging("footage_tenpercent");
									if (Math.random() > .5) {
										//Static
										usi_commons.load_view("rrQ6Z64uU8yqAAt6xpeos2K", "44221", usi_commons.device + language_key);
									} else {
										//Video
										usi_commons.load_view("CUQB44neZYHPi3BU9XlkFzl", "44227", usi_commons.device + language_key);
									}
								}
							}


						} else if (usi_app.is_music_in_cart || usi_app.is_music_page) {
							//********* Music Area
							var language_key = usi_app.get_language_key();
							if (usi_app.check_sub_total_price(49)) {
								//Flex Trial
								var split_key = usi_app.get_split_key("new", "new", false);
								if (split_key == 'current') {
									usi_commons.log('[ load ] * * * Load Music Flex Trial Current [language key: ' + language_key + '] * * *');
									usi_commons.load_view("T3f6LDJG9F6ImZzo9SttfR1", "45051", usi_commons.device + language_key);
								} else {
									usi_commons.log('[ load ] * * * Load Music Flex Trial New [language key: ' + language_key + '] * * *');
									usi_commons.load_view("FVDHHB9tPfCS1EJsDQr01wo", "45125", usi_commons.device + language_key);
								}
							} else if (usi_app.get_messaging("music_tenpercent") != null && usi_app.get_language_key() != "_english") {
								//Non Flex - Non English
								usi_app.messaging = usi_app.get_messaging("music_tenpercent");
								if (Math.random() > .5) {
									//Static
									usi_commons.load_view("T25hlbJiLDUt7F132sCIQ5P", "44365", usi_commons.device + language_key);
								} else {
									//Video
									usi_commons.load_view("QxSi81HhOmwMtyUmRoYUVV5", "44367", usi_commons.device + language_key);
								}
							} else if (usi_app.get_language_key() == "_english") {
								//Non Flex - English
								var version_key = usi_app.force_version || (Math.random() < 0.50 ? "_video" : "_static");
								usi_commons.log('[ load ] * * * Load Precise Promotion Music Page Exit TT [version:' + version_key + '] * * *');
								usi_commons.load_view("whtZAvezmewToNZMoUVqZJV", "41630", usi_commons.device + version_key);
							}
						}
					}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_split_key = function(split_key_a,split_key_b,has_enable){
			//currently only works with 2 options, but can be used multiple times on page. A should be Control, B Should be Test, has_enable will add an enable flag, and default to control (A)
			// To Do make work with array of options to allow for A/B/C/etc testing
			if(has_enable == "undefined"){
				has_enable = false;
			}

			var return_split_key = Math.random() < 0.5 ? split_key_a : split_key_b;

			if(has_enable){
				if(!usi_app.is_enabled){
					return_split_key = split_key_a;
				}
			}

			if (usi_app.force_group != "") {
				if(usi_app.force_group == "1"){
					return_split_key = split_key_a;
				}else{
					return_split_key = split_key_b
				}

			}
			return return_split_key;
		};

		usi_app.get_messaging = function(campaign) {
			var usi_language_key = usi_app.get_language_key().replace("_","");
			if (campaign == "images_sitewide_event") {
				if (usi_app.message_images_sitewide[usi_language_key] != "undefined") {
					return usi_app.message_images_sitewide[usi_language_key];
				}
			} else if (campaign == "video_sitewide_event") {
				if (usi_app.message_video_sitewide[usi_language_key] != "undefined") {
					return usi_app.message_video_sitewide[usi_language_key];
				}
			} else if (campaign == "images_freetrial") {
				if (usi_app.message_images_freetrial[usi_language_key] != "undefined") {
					return usi_app.message_images_freetrial[usi_language_key];
				}
			} else if (campaign == "footage_tenpercent") {
				if (usi_app.message_footage_tenpercent[usi_language_key] != "undefined") {
					return usi_app.message_footage_tenpercent[usi_language_key];
				}
			} else if (campaign == "music_tenpercent") {
				if (usi_app.message_music_tenpercent[usi_language_key] != "undefined") {
					return usi_app.message_music_tenpercent[usi_language_key];
				}
			} else if (campaign == "images_tenpercent") {
				if (usi_app.message_images_tenpercent[usi_language_key] != "undefined") {
					return usi_app.message_images_tenpercent[usi_language_key];
				}
			}
			return null;
		}

		usi_app.check_language_site = function() {
			try {
				usi_commons.log("usi_app.check_language_site()")
				if (!usi_app.is_create_account_page) {
					usi_app.is_czech_language = usi_app.url_href.match("/cs/") != null;
					usi_app.is_danish_language = usi_app.url_href.match("/da/") != null;
					usi_app.is_dutch_language = usi_app.url_href.match("/nl/") != null;
					usi_app.is_espanol_language = usi_app.url_href.match("/es/") != null;
					usi_app.is_finland_language = usi_app.url_href.match("/fi/") != null;
					usi_app.is_french_language = usi_app.url_href.match("/fr/") != null;
					usi_app.is_german_language = usi_app.url_href.match("/de/") != null || usi_app.url_href.match("/gr/") != null;
					usi_app.is_hungary_language = usi_app.url_href.match("/hu/") != null;
					usi_app.is_italian_language = usi_app.url_href.match("/it/") != null;
					usi_app.is_japanese_language = usi_app.url_href.match("/ja/") != null;
					usi_app.is_korean_language = usi_app.url_href.match("/ko/") != null;
					usi_app.is_norway_language = usi_app.url_href.match("/nb/") != null;
					usi_app.is_polish_language = usi_app.url_href.match("/pl/") != null;
					usi_app.is_portuguese_language = usi_app.url_href.match("/pt/") != null;
					usi_app.is_russia_language = usi_app.url_href.match("/ru/") != null;
					usi_app.is_simple_chinese_language = usi_app.url_href.match("/zh/") != null;
					usi_app.is_sweden_language = usi_app.url_href.match("/sv/") != null;
					usi_app.is_thai_language = usi_app.url_href.match("/th/") != null;
					usi_app.is_turkey_language = usi_app.url_href.match("/tr/") != null;
					usi_app.is_tradition_chinese_language = usi_app.url_href.match("/zh-hant/") != null;
					usi_app.is_hindi_language = usi_app.url_href.match("/hi/") != null;
					usi_app.is_tamil_language = usi_app.url_href.match("/ta/") != null;
					usi_app.is_telugu_language = usi_app.url_href.match("/te/") != null;
					usi_app.is_marathi_language = usi_app.url_href.match("/mr/") != null;
				} else {
					var decode_url = decodeURIComponent(location.href);
					var url = new URL(decode_url);
					var language_key = url.searchParams.get('hl')

					if (language_key == "cs") { usi_app.is_czech_language = true }
					else if (language_key == "da") { usi_app.is_danish_language = true }
					else if (language_key == "nl") { usi_app.is_dutch_language = true }
					else if (language_key == "es") { usi_app.is_espanol_language = true }
					else if (language_key == "fi") { usi_app.is_finland_language = true }
					else if (language_key == "fr") { usi_app.is_french_language = true }
					else if (language_key == "de") { usi_app.is_german_language = true }
					else if (language_key == "it") { usi_app.is_italian_language = true }
					else if (language_key == "ja") { usi_app.is_japanese_language = true }
					else if (language_key == "ko") { usi_app.is_korean_language = true }
					else if (language_key == "nb") { usi_app.is_norway_language = true }
					else if (language_key == "pl") { usi_app.is_polish_language = true }
					else if (language_key == "pt") { usi_app.is_portuguese_language = true }
					else if (language_key == "ru") { usi_app.is_russia_language = true }
					else if (language_key == "zh") { usi_app.is_simple_chinese_language = true }
					else if (language_key == "sv") { usi_app.is_sweden_language = true }
					else if (language_key == "th") { usi_app.is_thai_language = true }
					else if (language_key == "tr") { usi_app.is_turkey_language = true }
					else if (language_key == "zh-hant") { usi_app.is_tradition_chinese_language = true }
					else if (language_key == "hi") { usi_app.is_hindi_language = true }
					else if (language_key == "tn") { usi_app.is_tamil_language = true }
					else if (language_key == "te") { usi_app.is_telugu_language = true }
					else if (language_key == "mr") { usi_app.is_marathi_language = true }
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_language_key = function() {
			var language_key = "";
			try {
				if (usi_app.is_czech_language) {
					language_key = "_czech";
				} else if (usi_app.is_danish_language) {
					language_key = "_danish";
				} else if (usi_app.is_dutch_language) {
					language_key = "_dutch";
				} else if (usi_app.is_espanol_language) {
					language_key = "_espanol";
				} else if (usi_app.is_finland_language) {
					language_key = "_finland";
				} else if (usi_app.is_french_language) {
					language_key = "_french";
				} else if (usi_app.is_german_language) {
					language_key = "_german";
				} else if (usi_app.is_hungary_language) {
					language_key = "_hungary";
				} else if (usi_app.is_italian_language) {
					language_key = "_italian";
				} else if (usi_app.is_japanese_language) {
					language_key = "_japanese";
				} else if (usi_app.is_korean_language) {
					language_key = "_korean";
				} else if (usi_app.is_norway_language) {
					language_key = "_norway";
				} else if (usi_app.is_polish_language) {
					language_key = "_polish";
				} else if (usi_app.is_portuguese_language) {
					language_key = "_portuguese";
				} else if (usi_app.is_russia_language) {
					language_key = "_russia";
				} else if (usi_app.is_simple_chinese_language) {
					language_key = "_sichinese";
				} else if (usi_app.is_sweden_language) {
					language_key = "_sweden";
				} else if (usi_app.is_thai_language) {
					language_key = "_thai";
				} else if (usi_app.is_turkey_language) {
					language_key = "_turkey";
				} else if (usi_app.is_tradition_chinese_language) {
					language_key = "_trchinese";
				} else if (usi_app.is_hindi_language) {
					language_key = "_hindi";
				} else if (usi_app.is_tamil_language) {
					language_key = "_tamil";
				} else if (usi_app.is_telugu_language) {
					language_key = "_telugu";
				} else if (usi_app.is_marathi_language) {
					language_key = "_marathi";
				} else {
					language_key = "_english";
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return language_key;
		};
		
		usi_app.message_music_tenpercent = {
			"english": {header1:"Save 10% on music tracks and subscriptions.",cta:"Get Started"},
			"sichinese": {header1:"\u97F3\u4E50\u66F2\u76EE\u548C\u8BA2\u9605\u4EAB\u6709\u4E5D\u6298\u4F18\u60E0\u3002",cta:"\u5F00\u59CB\u4F7F\u7528"},
			"trchinese": {header1:"\u97F3\u6A02\u66F2\u76EE\u548C\u8A02\u95B1\u4EAB\u6709\u4E5D\u6298\u512A\u60E0\u3002",cta:"\u958B\u59CB\u4F7F\u7528"},
			"czech": {header1:"U\u0161et\u0159ete 10 % na hudebn\u00EDch skladb\u00E1ch a p\u0159edplatn\u00E9m.",cta:"Za\u010D\u00EDt"},
			"danish": {header1:"Spar 10 % p\u00E5 musiknumre og abonnementer",cta:"Kom i gang"},
			"finland": {header1:"Nyt voit s\u00E4\u00E4st\u00E4\u00E4 jopa 10% musiikista ja tilauksista.",cta:"Aloita t\u00E4st\u00E4"},
			"hungary": {header1:"10%-os megtakar\u00EDt\u00E1s a zenesz\u00E1mokon \u00E9s az el\u0151fizet\u00E9sen",cta:"Pr\u00F3b\u00E1lja ki most"},
			"norway": {header1:"Spar 10 % p\u00E5 musikkfiler og abonnementer.",cta:"Kom i gang"},
			"polish": {header1:"Zaoszcz\u0119d\u017A 10% na utworach muzycznych i subskrypcjach.",cta:"Rozpocznij"},
			"sweden": {header1:"Spara 10% p\u00E5 l\u00E5tar och abonnemang",cta:"Kom ig\u00E5ng"},
			"thai": {header1:"\u0E1B\u0E23\u0E30\u0E2B\u0E22\u0E31\u0E14 10% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E41\u0E17\u0E23\u0E47\u0E01\u0E40\u0E1E\u0E25\u0E07\u0E41\u0E25\u0E30\u0E01\u0E32\u0E23\u0E2A\u0E21\u0E31\u0E04\u0E23\u0E2A\u0E21\u0E32\u0E0A\u0E34\u0E01",cta:"\u0E40\u0E23\u0E34\u0E48\u0E21\u0E15\u0E49\u0E19"},
			"turkey": {header1:"M\u00FCzik par\u00E7alar\u0131 ve aboneliklerde %10 tasarruf edin.",cta:"\u015Eimdi Ba\u015Fla"},
			"italian": {header1:"Risparmia il 10% su tracce musicali e abbonamenti.",cta:"Inizia ora"},
			"espanol": {header1:"Ahorra 10% en pistas y suscripciones de m\u00FAsica",cta:"Comenzar"},
			"french": {header1:"\u00C9conomisez 10 % sur la musique et les abonnements.",cta:"Lancez-vous"},
			"portuguese": {header1:"Poupe 10% em faixas de m\u00FAsica e subscri\u00E7\u00F5es.",cta:"Comece agora"},
			"german": {header1:"Spare jetzt 10% auf Musik und Abos.",cta:"Loslegen"},
			"dutch": {header1:"Bespaar 10% op muzieknummers en abonnementen.",cta:"Begin nu"},
			"japanese": {header1:"\u97F3\u697D\u7D20\u6750\u3068\u5B9A\u984D\u30D7\u30E9\u30F3\u304C10\uFF05\u5272\u5F15",cta:"\u4ECA\u3059\u3050\u306F\u3058\u3081\u308B"},
			"hindi": {header1:"\u0938\u0902\u0917\u0940\u0924 \u091F\u094D\u0930\u0948\u0915 \u0914\u0930 \u0938\u092C\u094D\u0938\u0915\u094D\u0930\u093F\u092A\u094D\u0936\u0928 \u092A\u0930 10% \u092C\u091A\u093E\u090F\u0902\u0964",cta:"\u0936\u0941\u0930\u0941\u0906\u0924 \u0915\u0930\u0947\u0902"},
			"tamil": {header1:"\u0BAE\u0BBF\u0BAF\u0BC2\u0B9A\u0BBF\u0B95\u0BCD (\u0B87\u0B9A\u0BC8) \u0B9F\u0BBF\u0BB0\u0BBE\u0B95\u0BCD\u0B95\u0BC1\u0B95\u0BB3\u0BCD \u0BAE\u0BB1\u0BCD\u0BB1\u0BC1\u0BAE\u0BCD \u0B9A\u0BA8\u0BCD\u0BA4\u0BBE\u0B95\u0BCD\u0B95\u0BB3\u0BBF\u0BB2\u0BCD 10% \u0B9A\u0BC7\u0BAE\u0BBF\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD.",cta:"\u0BA4\u0BCA\u0B9F\u0B99\u0BCD\u0B95\u0BB5\u0BC1\u0BAE\u0BCD"},
			"telugu": {header1:"\u0C2E\u0C4D\u0C2F\u0C42\u0C1C\u0C3F\u0C15\u0C4D \u0C1F\u0C4D\u0C30\u0C3E\u0C15\u0C4D\u200C\u0C32\u0C41 \u0C2E\u0C30\u0C3F\u0C2F\u0C41 \u0C38\u0C2C\u0C4D\u200C\u0C38\u0C4D\u0C15\u0C4D\u0C30\u0C3F\u0C2A\u0C4D\u0C37\u0C28\u0C4D\u200C\u0C32\u0C2A\u0C48 10% \u0C06\u0C26\u0C3E \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F.",cta:"\u0C2A\u0C4D\u0C30\u0C3E\u0C30\u0C02\u0C2D\u0C3F\u0C02\u0C1A\u0C02\u0C21\u0C3F"},
			"marathi": {header1:"\u0938\u0902\u0917\u0940\u0924 \u091F\u094D\u0930\u0945\u0915 \u0906\u0923\u093F \u0938\u0926\u0938\u094D\u092F\u0924\u094D\u0935\u093E\u0902\u0935\u0930 10% \u092C\u091A\u0924 \u0915\u0930\u093E.",cta:"\u0938\u0941\u0930\u0941 \u0915\u0930\u0942\u092F\u093E"}
		};

		usi_app.message_images_freetrial = {
			"english": {header1:"Get 10 free images",bullet1:"Try 10 images per month plan for free",bullet2:"Pay just $29/mo after your trial ends", bullet3:"If you cancel in the 1st month you pay nothing!",cta:"Start your free trial",url:"https://www.shutterstock.com/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"sichinese": {header1:"\u7ACB\u5373\u83B7\u53D610\u5F20\u514D\u8D39\u56FE\u7247",bullet1:"\u514D\u8D39\u8BD5\u7528\u6BCF\u670810\u5F20\u56FE\u7247\u8BA1\u5212",bullet2:"\u8BD5\u7528\u7ED3\u675F\u540E\u4EC5\u9700\u652F\u4ED829\u7F8E\u5143/\u6708",bullet3:"\u8BD5\u7528\u7ED3\u675F\u540E\u4EC5\u9700\u652F\u4ED829\u7F8E\u5143\u6708",cta:"\u5982\u679C\u60A8\u5728\u7B2C\u4E00\u4E2A\u6708\u53D6\u6D88\uFF0C\u5219\u65E0\u9700\u652F\u4ED8\u4EFB\u4F55\u8D39\u7528",url:"https://www.shutterstock.com/zh/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"trchinese": {header1:"\u7ACB\u5373\u7372\u53D610\u5F35\u514D\u8CBB\u5716\u7247",bullet1:"\u514D\u8CBB\u8A66\u7528\u6BCF\u670810\u5F35\u5716\u7247\u8A08\u5283",bullet2:"\u8A66\u7528\u7D50\u675F\u5F8C\u50C5\u9700\u652F\u4ED829\u7F8E\u5143\u6708",bullet3:"\u5982\u679C\u60A8\u5728\u7B2C\u4E00\u500B\u6708\u53D6\u6D88\uFF0C\u5247\u7121\u9700\u652F\u4ED8\u4EFB\u4F55\u8CBB\u7528\uFF01",cta:"\u7ACB\u5373\u514D\u8CBB\u8A66\u7528",url:"https://www.shutterstock.com/zh-Hant/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"czech": {header1:"Vyzkou\u0161ejte pl\u00E1n 10 sn\u00EDmk\u016F za m\u011Bs\u00EDc zdarma",bullet1:"Pla\u0165te jen $29/m\u011Bs\u00ED\u010Dn\u011B po zku\u0161ebn\u00ED dob\u011B",bullet2:"Pokud zru\u0161\u00EDte v prvn\u00EDm m\u011Bs\u00EDci, neplat\u00EDte nic!",bullet3:"",cta:"Vyzkou\u0161ejte zdarma ihned!",url:"https://www.shutterstock.com/cs/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"danish": {header1:"F\u00E5 10 gratis billeder nu",bullet1:"Pr\u00F8v abonnementet med 10 billeder om m\u00E5neden gratis",bullet2:"Betal kun 29 USD/md. efter din pr\u00F8veperiode slutter",bullet3:"Hvis du afbestiller i 1. m\u00E5ned, betaler du intet!",cta:"Pr\u00F8v det gratis nu",url:"https://www.shutterstock.com/da/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"finland": {header1:"Hanki 10 ilmaista kuvaa nyt",bullet1:"Kokeile 10 kuukausittaisen kuvan ohjelmaa ilmaiseksi",bullet2:"Kokeilun j\u00E4lkeen maksat vain 29 \u20AC/kk",bullet3:"Jos peruutat ensimm\u00E4isen kuukauden aikana, et joudu maksamaan mit\u00E4\u00E4n!",cta:"Kokeile ilmaiseksi nyt",url:"https://www.shutterstock.com/fi/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"hungary": {header1:"10 k\u00E9p ingyenesen",bullet1:"Pr\u00F3b\u00E1lja ki a havonta 10 k\u00E9pet tartalmaz\u00F3 csomagot",bullet2:"A pr\u00F3baid\u0151 ut\u00E1n a csomag mind\u00F6ssze 29 usd/h\u00F3",bullet3:"Ha m\u00E1r az els\u0151 h\u00F3napban lemondja, akkor nem fizet semmit!",cta:"Pr\u00F3b\u00E1lja ki ingyenesen",url:"https://www.shutterstock.com/hu/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"norway": {header1:"F\u00E5 10 gratis bilder n\u00E5",bullet1:"Pr\u00F8v abonnementet med 10 bilder per m\u00E5ned gratis",bullet2:"Betal kun $ 29/mnd etter pr\u00F8veperioden",bullet3:"Du betaler ingenting hvis du kansellerer i den f\u00F8rste m\u00E5neden!",cta:"Pr\u00F8v gratis n\u00E5",url:"https://www.shutterstock.com/nb/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"polish": {header1:"Otrzymaj 10 darmowych zdj\u0119\u0107 ju\u017C teraz",bullet1:"Wypr\u00F3buj plan z 10 zdj\u0119ciami miesi\u0119cznie za darmo",bullet2:"P\u0142a\u0107 tylko 29 $/mies. po zako\u0144czeniu okresu pr\u00F3bnego",bullet3:"Je\u015Bli zrezygnujesz w pierwszym miesi\u0105cu, nie zap\u0142acisz nic!",cta:"Wypr\u00F3buj teraz za darmo",url:"https://www.shutterstock.com/pl/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"russia": {header1:"\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 10 \u0431\u0435\u0441\u043F\u043B\u0430\u0442\u043D\u044B\u0445 \u0438\u0437\u043E\u0431\u0440\u0430\u0436\u0435\u043D\u0438\u0439 \u0441\u0435\u0439\u0447\u0430\u0441",bullet1:"\u0412\u043E\u0441\u043F\u043E\u043B\u044C\u0437\u0443\u0439\u0442\u0435\u0441\u044C \u0431\u0435\u0441\u043F\u043B\u0430\u0442\u043D\u044B\u043C \u0442\u0430\u0440\u0438\u0444\u043E\u043C \u0441 10 \u0438\u0437\u043E\u0431\u0440\u0430\u0436\u0435\u043D\u0438\u044F\u043C\u0438 \u0432 \u043C\u0435\u0441\u044F\u0446",bullet2:"\u041F\u043B\u0430\u0442\u0438\u0442\u0435 $29/\u043C\u0435\u0441\u044F\u0446 \u043F\u043E\u0441\u043B\u0435 \u043E\u043A\u043E\u043D\u0447\u0430\u043D\u0438\u044F \u043F\u0440\u043E\u0431\u043D\u043E\u0433\u043E \u043F\u0435\u0440\u0438\u043E\u0434\u0430",bullet3:"\u0415\u0441\u043B\u0438 \u0432\u044B \u043E\u0442\u043C\u0435\u043D\u0438\u0442\u0435 \u043F\u043E\u0434\u043F\u0438\u0441\u043A\u0443 \u0432 \u0442\u0435\u0447\u0435\u043D\u0438\u0435 \u043F\u0435\u0440\u0432\u043E\u0433\u043E \u043C\u0435\u0441\u044F\u0446\u0430, \u0432\u044B \u043D\u0438\u0447\u0435\u0433\u043E \u043D\u0435 \u0437\u0430\u043F\u043B\u0430\u0442\u0438\u0442\u0435!",cta:"\u041F\u043E\u043F\u0440\u043E\u0431\u0443\u0439\u0442\u0435 \u0431\u0435\u0441\u043F\u043B\u0430\u0442\u043D\u043E \u0441\u0435\u0439\u0447\u0430\u0441",url:"https://www.shutterstock.com/ru/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"sweden": {header1:"F\u00E5 10 bilder gratis nu",bullet1:"Prova planen med 10 bilder per m\u00E5nad gratis",bullet2:"Betala endast $29/m\u00E5nad efter provperioden",bullet3:"Om du avslutar under den f\u00F6rsta m\u00E5naden betalar du ingenting!",cta:"Testa gratis nu",url:"https://www.shutterstock.com/sv/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"thai": {header1:"\u0E23\u0E31\u0E1A 10 \u0E20\u0E32\u0E1E\u0E1F\u0E23\u0E35\u0E17\u0E31\u0E19\u0E17\u0E35",bullet1:"\u0E17\u0E14\u0E25\u0E2D\u0E07\u0E43\u0E0A\u0E49\u0E41\u0E1C\u0E19 10 \u0E20\u0E32\u0E1E\u0E15\u0E48\u0E2D\u0E40\u0E14\u0E37\u0E2D\u0E19\u0E1F\u0E23\u0E35",bullet2:"\u0E08\u0E48\u0E32\u0E22\u0E41\u0E04\u0E48\u0E40\u0E1E\u0E35\u0E22\u0E07 $29/\u0E40\u0E14\u0E37\u0E2D\u0E19 \u0E2B\u0E25\u0E31\u0E07\u0E08\u0E32\u0E01\u0E17\u0E35\u0E48\u0E2A\u0E34\u0E49\u0E19\u0E2A\u0E38\u0E14\u0E01\u0E32\u0E23\u0E17\u0E14\u0E25\u0E2D\u0E07\u0E43\u0E0A\u0E49\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13",bullet3:"\u0E2B\u0E32\u0E01\u0E04\u0E38\u0E13\u0E22\u0E01\u0E40\u0E25\u0E34\u0E01\u0E43\u0E19\u0E40\u0E14\u0E37\u0E2D\u0E19\u0E17\u0E35\u0E48 1 \u0E04\u0E38\u0E13\u0E08\u0E30\u0E44\u0E21\u0E48\u0E15\u0E49\u0E2D\u0E07\u0E08\u0E48\u0E32\u0E22\u0E2D\u0E30\u0E44\u0E23\u0E40\u0E25\u0E22!",cta:"\u0E17\u0E14\u0E25\u0E2D\u0E07\u0E43\u0E0A\u0E49\u0E1F\u0E23\u0E35\u0E17\u0E31\u0E19\u0E17\u0E35",url:"https://www.shutterstock.com/th/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"turkey": {header1:"\u015Eimdi 10 \u00FCcretsiz resim al",bullet1:"Ayl\u0131k 10 resim plan\u0131n\u0131 \u00FCcretsiz dene",bullet2:"Deneme s\u00FCresi bitince ayda sadece 29$ \u00F6de",bullet3:"\u0130lk ay iptal edersen hi\u00E7bir \u015Fey \u00F6demeyeceksin",cta:"\u015Eimdi \u00FCcretsiz dene",url:"https://www.shutterstock.com/tr/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"italian": {header1:"Ottieni subito 10 immagini gratis",bullet1:"Prova gratuitamente il piano di 10 immagini al mese",bullet2:"Paga solo 29 $/mese al termine del periodo di prova",bullet3:"Se annulli durante il primo mese non paghi nulla!",cta:"Prova ora gratis",url:"https://www.shutterstock.com/it/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"korean": {header1:"\uC9C0\uAE08 10\uAC1C\uC758 \uC774\uBBF8\uC9C0\uB97C \uBB34\uB8CC\uB85C \uBC1B\uC73C\uC138\uC694",bullet1:"\uB9E4\uC6D4 10\uAC1C\uC758 \uC774\uBBF8\uC9C0\uB97C \uBB34\uB8CC\uB85C \uC0AC\uC6A9\uD574 \uBCF4\uC138\uC694",bullet2:"\uD3C9\uAC00\uD310 \uC885\uB8CC \uD6C4 \uC6D4 $29\uB9CC \uC9C0\uBD88\uD558\uC138\uC694",bullet3:"\uCCAB \uB2EC\uC5D0 \uCDE8\uC18C \uC2DC \uC544\uBB34\uAC83\uB3C4 \uC9C0\uBD88\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4!",cta:"\uC9C0\uAE08 \uBC14\uB85C \uBB34\uB8CC \uCCB4\uD5D8\uD574\uBCF4\uC138\uC694",url:"https://www.shutterstock.com/ko/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"espanol": {header1:"Consigue 10 im\u00E1genes gratis ahora",bullet1:"Prueba gratis el plan de 10 im\u00E1genes por mes",bullet2:"Paga solo $29 al mes al terminar el periodo de prueba.",bullet3:"\u00A1Si cancelas dentro del primer mes, no pagas nada!",cta:"Prueba gratis ahora",url:"https://www.shutterstock.com/es/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"french": {header1:"Profitez de 10 images gratuites d\u00E8s aujourd\u2019hui",bullet1:"Essayez gratuitement l\u2019abonnement 10 images par mois",bullet2:"Payez seulement 29 $/mois \u00E0 la fin de votre p\u00E9riode d\u2019essai",bullet3:"Si vous r\u00E9siliez au cours du 1er mois, vous n\u2019avez rien \u00E0 payer !",cta:"Essayer gratuitement",url:"https://www.shutterstock.com/fr/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"portuguese": {header1:"Obtenha agora 10 imagens gratuitas",bullet1:"Experimente gratuitamente o plano de 10 imagens por m\u00EAs",bullet2:"Pague apenas 29$/m\u00EAs ap\u00F3s o seu per\u00EDodo experimental",bullet3:"Se cancelar no 1.\u00BA m\u00EAs, n\u00E3o paga nada!",cta:"Experimente agora de forma gratuita",url:"https://www.shutterstock.com/pt/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"german": {header1:"Sichern Sie sich jetzt 10 kostenlose Bilder",bullet1:"Testen Sie den Plan mit zehn kostenlosen Bildern pro Monat.",bullet2:"Nach dem Test zahlen Sie nur $29 pro Monat.",bullet3:"Wenn Sie im ersten Monat k\u00FCndigen, zahlen Sie nichts!",cta:"Jetzt kostenlos testen",url:"https://www.shutterstock.com/de/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"dutch": {header1:"Ontvang nu 10 gratis afbeeldingen",bullet1:"Probeer het abonnement gratis en ontvang 10 afbeeldingen",bullet2:"Betaal slechts $29 per maand nadat uw proefperiode is afgelopen",bullet3:"Als je opzegt in de 1e maand betaal je niets!",cta:"Probeer nu gratis",url:"https://www.shutterstock.com/nl/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"japanese": {header1:"\u4ECA\u306A\u3089\u753B\u50CF\u309210\u679A\u7121\u6599\u3067\u30D7\u30EC\u30BC\u30F3\u30C8",bullet1:"1\u30F6\u670810\u679A\u30D7\u30E9\u30F3\u3092\u7121\u6599\u3067\u304A\u8A66\u3057\u304F\u3060\u3055\u3044",bullet2:"\u30C8\u30E9\u30A4\u30A2\u30EB\u7D42\u4E86\u5F8C\u3001\u6708\u300529\u30C9\u30EB\u3092\u304A\u652F\u6255\u3044\u9802\u304D\u307E\u3059",bullet3:"1\u30F6\u6708\u4EE5\u5185\u306B\u89E3\u7D04\u3059\u308C\u3070\u3001\u652F\u6255\u3044\u306F\u4E00\u5207\u306A\u3057\uFF01",cta:"\u4ECA\u3059\u3050\u7121\u6599\u3067\u304A\u8A66\u3057\u3092",url:"https://www.shutterstock.com/ja/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"}
		};

		usi_app.message_footage_tenpercent = {
			"english": {header1:"Videos that make an impact",header2:"Get 10% off your footage order today",use_code:"",your_cart:"Your Cart", subtotal:"Subtotal", discount:"Discount", new_total:"New Subtotal",cta:"Redeem now"},
			"sichinese": {header1:"\u6709\u5F71\u54CD\u529B\u7684\u89C6\u9891",header2:"\u6709\u5F71\u54CD\u529B\u7684\u89C6\u9891",use_code:"",your_cart:"\u60A8\u7684\u8D2D\u7269\u8F66", subtotal:"\u5C0F\u8BA1", discount:"\u6298\u6263", new_total:"\u65B0\u5C0F\u8BA1",cta:"\u7ACB\u5373\u5151\u6362"},
			"trchinese": {header1:"\u6709\u5F71\u97FF\u529B\u7684\u8996\u983B",header2:"\u4ECA\u5929\u5C31\u53EF\u4EE5\u4EAB\u53D7\u8996\u983B\u8A02\u55AE10%\u7684\u6298\u6263",use_code:"",your_cart:"\u60A8\u7684\u8CFC\u7269\u8ECA", subtotal:"\u5C0F\u8A08", discount:"\u6298\u6263", new_total:"\u65B0\u5C0F\u8A08",cta:"\u7ACB\u5373\u514C\u63DB"},
			"czech": {header1:"Videa, kter\u00E1 zap\u016Fsob\u00ED",header2:"Z\u00EDskejte 10% slevu na objedn\u00E1vku z\u00E1b\u011Br\u016F je\u0161t\u011B dnes",use_code:"",your_cart:"V\u00E1\u0161 ko\u0161\u00EDk", subtotal:"Mezisou\u010Det", discount:"Sleva", new_total:"Nov\u00FD Mezisou\u010Det",cta:"Uplatnit ihned"},
			"danish": {header1:"Videoer, der g\u00F8r indtryk",header2:"F\u00E5 10% i rabat p\u00E5 din bestilling af filmoptagelser i dag",use_code:"",your_cart:"Din kurv", subtotal:"Subtotal", discount:"Rabat", new_total:"Ny Subtotal",cta:"ndl\u00F8s nu"},
			"finland": {header1:"Videoita, jotka tekev\u00E4t vaikutuksen",header2:"Saat 10 % alennuksen videomateriaalitilauksestasi t\u00E4n\u00E4\u00E4n",use_code:"",your_cart:"Ostoskorisi", subtotal:"V\u00E4lisumma", discount:"Alennus", new_total:"Uusi v\u00E4lisumma",cta:"Lunasta nyt"},
			"hungary": {header1:"Vide\u00F3k, amelyek nagy hat\u00E1st gyakorolnak",header2:"10%-os engedm\u00E9ny a felv\u00E9telekb\u0151l ma",use_code:"",your_cart:"A kosarad", subtotal:"R\u00E9sz\u00F6sszeg", discount:"Kedvezm\u00E9ny", new_total:"\u00DAj r\u00E9sz\u00F6sszeg",cta:"V\u00C1LTSA BE MOST"},
			"norway": {header1:"Videoer som gj\u00F8r inntrykk",header2:"F\u00E5 10 % rabatt p\u00E5 videobestillingen din i dag",use_code:"",your_cart:"", subtotal:"Delsum", discount:"Rabatt", new_total:"Ny delsum", cta:"L\u00F8s inn n\u00E5"},
			"polish": {header1:"Znajd\u017A idealn\u0105 muzyk\u0119",header2:"Zaoszcz\u0119d\u017A 10% na swoich utworach muzycznych ju\u017C dzi\u015B",use_code:"",your_cart:"Tw\u00F3j w\u00F3zek", subtotal:"Suma cz\u0119\u015Bciowa", discount:"Rabat", new_total:"Nowa suma cz\u0119\u015Bciowa",cta:"SKORZYSTAJ TERAZ"},
			"russia": {header1:"\u0412\u0438\u0434\u0435\u043E, \u043A\u043E\u0442\u043E\u0440\u044B\u0435 \u043F\u0440\u043E\u0438\u0437\u0432\u043E\u0434\u044F\u0442 \u0432\u043F\u0435\u0447\u0430\u0442\u043B\u0435\u043D\u0438\u0435",header2:"10% \u0441\u043A\u0438\u0434\u043A\u0430 \u043D\u0430 \u0432\u044B\u0431\u0440\u0430\u043D\u043D\u044B\u0439 \u0432\u0430\u043C\u0438 \u0432\u0438\u0434\u0435\u043E\u0440\u044F\u0434 \u0441\u0435\u0433\u043E\u0434\u043D\u044F",use_code:"",your_cart:"\u0412\u0430\u0448\u0430 \u043A\u043E\u0440\u0437\u0438\u043D\u0430", subtotal:"\u041F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0438\u0442\u043E\u0433", discount:"\u0421\u043A\u0438\u0434\u043A\u0430", new_total:"\u041D\u043E\u0432\u044B\u0439 \u043F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0438\u0442\u043E\u0433",cta:"\u0417\u0430\u0431\u0435\u0440\u0438\u0442\u0435 \u043F\u0440\u044F\u043C\u043E \u0441\u0435\u0439\u0447\u0430\u0441"},
			"sweden": {header1:"Videor som g\u00F6r ett intryck",header2:"F\u00E5 10% rabatt p\u00E5 din videobest\u00E4llning idag",use_code:"",your_cart:"Din vagn", subtotal:"Delsumma", discount:"Rabatt", new_total:"Ny delsumma",cta:"Anv\u00E4nd nu"},
			"thai": {header1:"\u0E27\u0E34\u0E14\u0E35\u0E42\u0E2D\u0E17\u0E35\u0E48\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E1C\u0E25\u0E01\u0E23\u0E30\u0E17\u0E1A",header2:"\u0E23\u0E31\u0E1A\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 10% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E1F\u0E38\u0E15\u0E40\u0E17\u0E08\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49",use_code:"",your_cart:"\u0E23\u0E16\u0E40\u0E02\u0E47\u0E19\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13", subtotal:"\u0E22\u0E2D\u0E14\u0E23\u0E27\u0E21", discount:"\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14", new_total:"\u0E22\u0E2D\u0E14\u0E23\u0E27\u0E21\u0E43\u0E2B\u0E21\u0E48",cta:"\u0E23\u0E31\u0E1A\u0E40\u0E25\u0E22\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49"},
			"turkey": {header1:"Ak\u0131llarda kalan videolar",header2:"Video sipari\u015Finde bug\u00FCn %10 indirim kazan",use_code:"",your_cart:"sepetiniz", subtotal:"Ara Toplam", discount:"\u0130ndirim", new_total:"Yeni Ara Toplam",cta:"\u015Eimdi kullan"},
			"italian": {header1:"Video che lasciano il segno",header2:"Ricevi subito uno sconto del 10% sul tuo ordine di filmati",use_code:"",your_cart:"Il tuo carrello", subtotal:"Subtotale", discount:"Sconto", new_total:"Nuovo Subtotale",cta:"Approfittane ora"},
			"korean": {header1:"\uD6A8\uACFC \uB9CC\uC810\uC758 \uB3D9\uC601\uC0C1\uC744 \uAD6C\uB9E4\uD558\uC138\uC694",header2:"\uC624\uB298 \uC8FC\uBB38\uD558\uBA74 10% \uD560\uC778",use_code:"",your_cart:"\uC7A5\uBC14\uAD6C\uB2C8", subtotal:"\uC18C\uACC4", discount:"\uD560\uC778", new_total:"\uC0C8 \uC18C\uACC4",cta:"\uC9C0\uAE08 \uD61C\uD0DD\uBC1B\uAE30"},
			"espanol": {header1:"V&iacute;deos que causan impacto",header2:"Consiga hoy 10% en su orden de v&iacute;deo",use_code:"",your_cart:"Tu Carrito", subtotal:"Precio", discount:"Descuento Nuevo", new_total:"Precio Nuevo",cta:"Canjear ahora"},
			"french": {header1:"Des vid\u00E9os qui font de l\u2019effet",header2:"Profitez d\u00E8s aujourd\u2019hui de 10\u00A0% de r\u00E9duction sur vos vid\u00E9os",use_code:"",your_cart:"Votre panier", subtotal:"Sous-total", discount:"Remise", new_total:"Nouveau Sous-Total",cta:"Profitez-en maintenant"},
			"portuguese": {header1:"Videos queles causam um impacto",header2:"Consigue 10 % de desconto de teu ordem de material hoje",use_code:"",your_cart:"Seu carrinho", subtotal:"Subtotal", discount:"Desconto", new_total:"Novo Subtotal",cta:"Redimir agora"},
			"german": {header1:"Videos, die \u00FCberzeugen",header2:"Erhalten Sie heute 10% Rabatt auf Ihr Bildmaterial",use_code:"",your_cart:"Ihr Warenkorb", subtotal:"Subtotal", discount:"Discount", new_total:"New Subtotal",cta:"Jetzt einl\u00F6sen"},
			"dutch": {header1:"Video's die impact maken.",header2:"Ontvang vandaag 10% korting op uw beeldmateriaal bestelling",use_code:"",your_cart:"sepetiniUw winkelwagenz", subtotal:"Subtotaal", discount:"Korting", new_total:"Nieuw subtotaal",cta:"Ontvang nu"},
			"japanese": {header1:"\u30A4\u30F3\u30D1\u30AF\u30C8\u306E\u3042\u308B\u30D3\u30C7\u30AA",header2:"\u672C\u65E5\u3054\u6CE8\u6587\u306B\u306A\u308B\u3068\u52D5\u753B\u304C10\uFF05\u30AA\u30D5",use_code:"",your_cart:"\u3042\u306A\u305F\u306E\u30AB\u30FC\u30C8", subtotal:"\u5C0F\u8A08", discount:"\u5272\u5F15", new_total:"\u65B0\u3057\u3044\u5C0F\u8A08",cta:"\u4ECA\u3059\u3050\u3054\u5229\u7528\u304F\u3060\u3055\u3044"},
			"hindi": {header1:"\u0910\u0938\u0947 \u0935\u0940\u0921\u093F\u092F\u094B \u091C\u094B \u092A\u094D\u0930\u092D\u093E\u0935 \u0921\u093E\u0932\u0924\u0947 \u0939\u0948\u0902",header2:"\u0906\u091C \u0939\u0940 \u0905\u092A\u0928\u0947 \u092B\u093C\u0941\u091F\u0947\u091C \u0911\u0930\u094D\u0921\u0930 \u092A\u0930 10% \u0915\u0940 \u091B\u0942\u091F \u092A\u093E\u090F\u0902",use_code:"",your_cart:"Your Cart", subtotal:"Subtotal", discount:"Discount", new_total:"New Subtotal",cta:"\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902"},
			"tamil": {header1:"\u0BA4\u0BBE\u0B95\u0BCD\u0B95\u0BA4\u0BCD\u0BA4\u0BC8 \u0B8F\u0BB1\u0BCD\u0BAA\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC1\u0BAE\u0BCD \u0BB5\u0BC0\u0B9F\u0BBF\u0BAF\u0BCB\u0B95\u0BCD\u0B95\u0BB3\u0BCD", header2:"\u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BC1\u0B95\u0BCD\u0B95\u0BBE\u0BA9 \u0BAA\u0BA4\u0BBF\u0BB5\u0BC8 \u0B87\u0BA9\u0BCD\u0BB1\u0BC7 \u0B86\u0BB0\u0BCD\u0B9F\u0BB0\u0BCD \u0B9A\u0BC6\u0BAF\u0BCD\u0BA4\u0BC1 10% \u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF \u0BAA\u0BC6\u0BB1\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",use_code:"",your_cart:"Your Cart", subtotal:"Subtotal", discount:"Discount", new_total:"New Subtotal",cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC7 \u0BB0\u0BC0\u0B9F\u0BC0\u0BAE\u0BCD \u0B9A\u0BC6\u0BAF\u0BCD\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD"},
			"telugu": {header1:"\u0C2A\u0C4D\u0C30\u0C2D\u0C3E\u0C35\u0C02 \u0C1A\u0C42\u0C2A\u0C47 \u0C35\u0C40\u0C21\u0C3F\u0C2F\u0C4B\u0C32\u0C41", header2:"\u0C08\u0C30\u0C4B\u0C1C\u0C47 \u0C2E\u0C40 \u0C2B\u0C41\u0C1F\u0C47\u0C1C\u0C4D\u0C06 \u0C30\u0C4D\u0C21\u0C30\u0C4D\u200C\u0C2A\u0C48 10% \u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41 \u0C2A\u0C4A\u0C02\u0C26\u0C02\u0C21\u0C3F",use_code:"",your_cart:"Your Cart", subtotal:"Subtotal", discount:"Discount", new_total:"New Subtotal",cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D\u0C1A\u0C47 \u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F\n"},
			"marathi": {header1:"\u092A\u094D\u0930\u092D\u093E\u0935\u093F\u0924 \u0915\u0930\u0923\u093E\u0930\u0947 \u0935\u094D\u0939\u093F\u0921\u093F\u0913", header2:"\u0906\u091C\u091A \u0924\u0941\u092E\u091A\u094D\u092F\u093E \u092B\u0941\u091F\u0947\u091C \u0911\u0930\u094D\u0921\u0930\u0935\u0930 10% \u0938\u0942\u091F \u092E\u093F\u0933\u0935\u093E",use_code:"",your_cart:"Your Cart", subtotal:"Subtotal", discount:"Discount", new_total:"New Subtotal",cta:"\u0906\u0924\u093E \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E"}
		};

		usi_app.message_images_sitewide = {
			"english": {header1:"Share your colors",header2:"Save 25% while also giving back",use_code: "Use code",cta: "Get started"},
			"sichinese": {header1:"\u5206\u4EAB\u4F60\u7684\u989C\u8272",header2:"\u5728\u56DE\u9988\u7684\u540C\u65F6\u4EAB\u670975\u6298\u4F18\u60E0",use_code:"",cta:"\u5F00\u59CB"},
			"trchinese": {header1:"\u5206\u4EAB\u4F60\u7684\u984F\u8272",header2:"\u5728\u56DE\u994B\u7684\u540C\u6642\u4EAB\u670975\u6298\u512A\u60E0",use_code:"",cta:"\u958B\u59CB"},
			"czech": {header1:"Najd\u{11B}te perfektn\u{ED} sn\u{ED}mek",header2:"U\u{161}et\u{159}ete 25 % na sn\u{ED}mkov\u{FD}ch podkladech",use_code:"",cta:"Uplatnit nyn\u{ED}"},
			"danish": {header1:"Find det perfekte billede",header2:"Spar 25% p\u{E5} billedaktiver",use_code:"",cta:"Indl\u{F8}s nu"},
			"finland": {header1:"L\u{F6}yd\u{E4} t\u{E4}ydellinen kuva",header2:"S\u{E4}\u{E4}st\u{E4} 25 % kuvamateriaaleista",use_code:"",cta:"Lunasta Nyt"},
			"hungary": {header1:"Tal\u{E1}ld meg a t\u{F6}k\u{E9}letes k\u{E9}pet",header2:"Sp\u{F3}rolj 25%-ot a k\u{E9}pi elemeken",use_code:"",cta:"V\u{E1}ltsd be most"},
			"norway": {header1:"Finn det perfekte bildet",header2:"Spar 25 % p\u{E5} bilder og illustrasjoner",use_code:"",cta:"Aktiver tilbudet n\u{E5}"},
			"polish": {header1:"Znajd\u{17A} idealn\u{105} grafik\u{119}",header2:"Oszdz\u{119}d\u{17A} 25% na grafikach",use_code:"",cta:"Skorzystaj teraz"},
			"russia": {header1:"\u{41D}\u{430}\u{439}\u{434}\u{438} \u{438}\u{434}\u{435}\u{430}\u{43B}\u{44C}\u{43E}\u{435} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{435}",header2:"\u{421}\u{44D}\u{43A}\u{43E}\u{43D}\u{43E}\u{43C}\u{44C}\u{442}\u{435} 25% \u{43D}\u{430} \u{430}\u{43A}\u{442}\u{438}\u{432}\u{430}\u{445} \u{43F}\u{43E} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{44E}",use_code:"",cta:"\u{417}\u{430}\u{431}\u{435}\u{440}\u{438}\u{442}\u{435} \u{43F}\u{440}\u{44F}\u{43C}\u{43E} \u{441}\u{435}\u{439}\u{447}\u{430}\u{441}"},
			"sweden": {header1:"Hitta den perfekta bilden",header2:"25% rabatt p\u{E5} bildresurser",use_code:"",cta:"L\u{F6}s in nu"},
			"thai": {header1:"\u{E04}\u{E49}\u{E19}\u{E2B}\u{E32}\u{E20}\u{E32}\u{E1E}\u{E17}\u{E35}\u{E48}\u{E2A}\u{E21}\u{E1A}\u{E39}\u{E23}\u{E13}\u{E4C}\u{E41}\u{E1A}\u{E1A}",header2:"\u{E1B}\u{E23}\u{E30}\u{E2B}\u{E22}\u{E31}\u{E14} 25% \u{E2A}\u{E33}\u{E2B}\u{E23}\u{E31}\u{E1A}\u{E40}\u{E19}\u{E37}\u{E49}\u{E2D}\u{E2B}\u{E32}\u{E23}\u{E39}\u{E1B}\u{E20}\u{E32}\u{E1E}",use_code:"",cta:"\u{E1A}\u{E15}\u{E2D}\u{E19}\u{E19}\u{E35}\u{E49}"},
			"turkey": {header1:"M\u{FC}kemmel resmi bul",header2:"Resim \u{FC}r\u{FC}nlerinde % tasarruf",use_code:"",cta:"\u{15E}imdi Kullan"},
			"italian": {header1:"Trova l'immagine perfetta",header2:"Risparmia il 25% sulle immagini",use_code:"",cta:"Approfittane ora"},
			"korean": {header1:"\u{C644}\u{BCBD}\u{D55C} \u{C774}\u{BBF8}\u{C9C0}\u{B97C} \u{CC3E}\u{C544}\u{BCF4}\u{C138}\u{C694}",use_code:"",cta:"\u{C774}\u{BBF8}\u{C9C0} \u{D30C}\u{C77C} \u{C694}\u{AE08}\u{C744} 25% \u{C544}\u{AEF4} \u{B4DC}\u{B9BD}\u{B2C8}\u{B2E4}",header2:"\u{C9C0}\u{AE08} \u{C774}\u{C6A9}\u{D558}\u{AE30}"},
			"espanol": {header1:"Encuentra la imagen perfecta",header2:"Ahorra 25% en elementos de imagen",use_code:"",cta:"Canjear Ahora"},
			"french": {header1:"Trouvez l\u{2019}image id\u{E9}ale",header2:"\u{C9}conomisez 25 % sur vos images",use_code:"",cta:"En profiter maintenant"},
			"portuguese": {header1:"Encontre a imagem perfeita",header2:"Poupe 25% em imagens",use_code:"",cta:"Obtenha agora"},
			"german": {header1:"Finden Sie das perfekte Bild",header2:"25 % bei Bildern sparen",use_code:"",cta:"Jetzt einl\u{F6}sen"},
			"dutch": {header1:"Vind de perfecte afbeelding",header2:"Bespaar 25% op afbeelding assets",use_code:"",cta:"Ontvang nu"},
			"japanese": {header1:"\u{6700}\u{9069}\u{306A}\u{753B}\u{50CF}\u{3092}\u{898B}\u{3064}\u{3051}\u{3066}\u{304F}\u{3060}\u{3055}\u{3044}",header2:"\u{753B}\u{50CF}\u{30A2}\u{30BB}\u{30C3}\u{30C8}\u{304C}25\u{FF05}\u{5F15}\u{304D}",use_code:"",cta:"\u{4ECA}\u{3059}\u{3050}\u{3054}\u{5229}\u{7528}\u{304F}\u{3060}\u{3055}\u{3044}"}
		};

		usi_app.message_images_tenpercent = {
			"english": {header1:"Find the perfect Image", header2:"Save 10% on image assets",use_code: "Use code",cta: "Redeem now"},
			"sichinese": {header1:"\u5206\u4EAB\u4F60\u7684\u989C\u8272",header2:"\u5728\u56DE\u9988\u7684\u540C\u65F6\u4EAB\u670975\u6298\u4F18\u60E0",use_code:"",cta:"\u5F00\u59CB"},
			"trchinese": {header1:"\u5206\u4EAB\u4F60\u7684\u984F\u8272",header2:"\u5728\u56DE\u994B\u7684\u540C\u6642\u4EAB\u670975\u6298\u512A\u60E0",use_code:"",cta:"\u958B\u59CB"},
			"czech": {header1:"Najd\u{11B}te perfektn\u{ED} sn\u{ED}mek",header2:"U\u{161}et\u{159}ete 10 % na sn\u{ED}mkov\u{FD}ch podkladech",use_code:"",cta:"Uplatnit nyn\u{ED}"},
			"danish": {header1:"Find det perfekte billede",header2:"Spar 10% p\u{E5} billedaktiver",use_code:"",cta:"Indl\u{F8}s nu"},
			"finland": {header1:"L\u{F6}yd\u{E4} t\u{E4}ydellinen kuva",header2:"S\u{E4}\u{E4}st\u{E4} 10 % kuvamateriaaleista",use_code:"",cta:"Lunasta Nyt"},
			"hungary": {header1:"Tal\u{E1}ld meg a t\u{F6}k\u{E9}letes k\u{E9}pet",header2:"Sp\u{F3}rolj 10%-ot a k\u{E9}pi elemeken",use_code:"",cta:"V\u{E1}ltsd be most"},
			"norway": {header1:"Finn det perfekte bildet",header2:"Spar 10 % p\u{E5} bilder og illustrasjoner",use_code:"",cta:"Aktiver tilbudet n\u{E5}"},
			"polish": {header1:"Znajd\u{17A} idealn\u{105} grafik\u{119}",header2:"Oszdz\u{119}d\u{17A} 10% na grafikach",use_code:"",cta:"Skorzystaj teraz"},
			"russia": {header1:"\u{41D}\u{430}\u{439}\u{434}\u{438} \u{438}\u{434}\u{435}\u{430}\u{43B}\u{44C}\u{43E}\u{435} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{435}",header2:"\u{421}\u{44D}\u{43A}\u{43E}\u{43D}\u{43E}\u{43C}\u{44C}\u{442}\u{435} 10% \u{43D}\u{430} \u{430}\u{43A}\u{442}\u{438}\u{432}\u{430}\u{445} \u{43F}\u{43E} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{44E}",use_code:"",cta:"\u{417}\u{430}\u{431}\u{435}\u{440}\u{438}\u{442}\u{435} \u{43F}\u{440}\u{44F}\u{43C}\u{43E} \u{441}\u{435}\u{439}\u{447}\u{430}\u{441}"},
			"sweden": {header1:"Hitta den perfekta bilden",header2:"10% rabatt p\u{E5} bildresurser",use_code:"",cta:"L\u{F6}s in nu"},
			"thai": {header1:"\u{E04}\u{E49}\u{E19}\u{E2B}\u{E32}\u{E20}\u{E32}\u{E1E}\u{E17}\u{E35}\u{E48}\u{E2A}\u{E21}\u{E1A}\u{E39}\u{E23}\u{E13}\u{E4C}\u{E41}\u{E1A}\u{E1A}",header2:"\u{E1B}\u{E23}\u{E30}\u{E2B}\u{E22}\u{E31}\u{E14} 10% \u{E2A}\u{E33}\u{E2B}\u{E23}\u{E31}\u{E1A}\u{E40}\u{E19}\u{E37}\u{E49}\u{E2D}\u{E2B}\u{E32}\u{E23}\u{E39}\u{E1B}\u{E20}\u{E32}\u{E1E}",use_code:"",cta:"\u{E1A}\u{E15}\u{E2D}\u{E19}\u{E19}\u{E35}\u{E49}"},
			"turkey": {header1:"M\u{FC}kemmel resmi bul",header2:"Resim \u{FC}r\u{FC}nlerinde % tasarruf",use_code:"",cta:"\u{15E}imdi Kullan"},
			"italian": {header1:"Trova l'immagine perfetta",header2:"Risparmia il 10% sulle immagini",use_code:"",cta:"Approfittane ora"},
			"korean": {header1:"\u{C644}\u{BCBD}\u{D55C} \u{C774}\u{BBF8}\u{C9C0}\u{B97C} \u{CC3E}\u{C544}\u{BCF4}\u{C138}\u{C694}",use_code:"",cta:"\u{C774}\u{BBF8}\u{C9C0} \u{D30C}\u{C77C} \u{C694}\u{AE08}\u{C744} 10% \u{C544}\u{AEF4} \u{B4DC}\u{B9BD}\u{B2C8}\u{B2E4}",header2:"\u{C9C0}\u{AE08} \u{C774}\u{C6A9}\u{D558}\u{AE30}"},
			"espanol": {header1:"Encuentra la imagen perfecta",header2:"Ahorra 10% en elementos de imagen",use_code:"",cta:"Canjear Ahora"},
			"french": {header1:"Trouvez l\u{2019}image id\u{E9}ale",header2:"\u{C9}conomisez 10 % sur vos images",use_code:"",cta:"En profiter maintenant"},
			"portuguese": {header1:"Encontre a imagem perfeita",header2:"Poupe 10% em imagens",use_code:"",cta:"Obtenha agora"},
			"german": {header1:"Finden Sie das perfekte Bild",header2:"10 % bei Bildern sparen",use_code:"",cta:"Jetzt einl\u{F6}sen"},
			"dutch": {header1:"Vind de perfecte afbeelding",header2:"Bespaar 10% op afbeelding assets",use_code:"",cta:"Ontvang nu"},
			"japanese": {header1:"\u{6700}\u{9069}\u{306A}\u{753B}\u{50CF}\u{3092}\u{898B}\u{3064}\u{3051}\u{3066}\u{304F}\u{3060}\u{3055}\u{3044}",header2:"\u{753B}\u{50CF}\u{30A2}\u{30BB}\u{30C3}\u{30C8}\u{304C}10\u{FF05}\u{5F15}\u{304D}",use_code:"",cta:"\u{4ECA}\u{3059}\u{3050}\u{3054}\u{5229}\u{7528}\u{304F}\u{3060}\u{3055}\u{3044}"},
			"hindi": {header1:"\u092C\u093F\u0932\u094D\u0915\u0941\u0932 \u0938\u0939\u0940 \u0907\u092E\u0947\u091C \u0916\u094B\u091C\u0947\u0902",header2:"\u0907\u092E\u0947\u091C \u090F\u0938\u0947\u091F \u092A\u0930 10% \u0915\u0940 \u092C\u091A\u0924 \u0915\u0930\u0947\u0902",use_code:"",cta:"\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902"},
			"tamil": {header1:"\u0BA4\u0BC1\u0BB3\u0BCD\u0BB3\u0BBF\u0BAF\u0BAE\u0BBE\u0BA9 \u0B87\u0BAE\u0BC7\u0B9C\u0BC8(\u0BAA\u0B9F\u0BAE\u0BCD) \u0B95\u0BA3\u0BCD\u0B9F\u0BC1\u0BAA\u0BBF\u0B9F\u0BC1\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header2:"\u0B87\u0BAE\u0BC7\u0B9C\u0BCD \u0B85\u0BB8\u0BCD\u0BB8\u0BC6\u0B9F\u0BCD\u0B9F\u0BBF\u0BB2\u0BCD (\u0B9A\u0BC7\u0B95\u0BB0\u0BBF\u0BAA\u0BCD\u0BAA\u0BC1) 10% \u0B90 \u0B9A\u0BC7\u0BAE\u0BBF\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",use_code:"",cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC7 \u0BB0\u0BC0\u0B9F\u0BC0\u0BAE\u0BCD \u0B9A\u0BC6\u0BAF\u0BCD\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD"},
			"telugu": {header1:"\u0C38\u0C30\u0C48\u0C28 \u0C1A\u0C3F\u0C24\u0C4D\u0C30\u0C3E\u0C28\u0C4D\u0C28\u0C3F \u0C15\u0C28\u0C41\u0C17\u0C4A\u0C28\u0C02\u0C21\u0C3F",header2:"\u0C1A\u0C3F\u0C24\u0C4D\u0C30 \u0C05\u0C38\u0C46\u0C1F\u0C4D\u0C38\u0C4D\u200C\u0C2A\u0C48 10% \u0C06\u0C26\u0C3E \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F",use_code:"",cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F"},
			"marathi": {header1:"\u092F\u094B\u0917\u094D\u092F \u0907\u092E\u0947\u091C \u0936\u094B\u0927\u093E",header2:"\u0907\u092E\u0947\u091C \u090F\u0938\u0947\u091F\u0935\u0930 10% \u092C\u091A\u0924 \u0915\u0930\u093E",use_code:"",cta:"\u0906\u0924\u093E \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E"}
		};

		usi_app.message_video_sitewide = {
			"english": {header1:"Share your colors",header2:"Save 25% while also giving back ",use_code:"Use code ",cta:"Get started"},
			"sichinese": {header1:"\u6709\u5F71\u54CD\u529B\u7684\u89C6\u9891",header2:"\u4ECA\u5929\u5C31\u53EF\u4EE5\u4EAB\u53D7\u89C6\u9891\u8BA2\u535525%\u7684\u6298\u6263",use_code:"",cta:"\u7ACB\u5373\u5151\u6362"},
			"trchinese": {header1:"\u6709\u5F71\u97FF\u529B\u7684\u8996\u983B",header2:"\u4ECA\u5929\u5C31\u53EF\u4EE5\u4EAB\u53D7\u8996\u983B\u8A02\u55AE25%\u7684\u6298\u6263",use_code:"",cta:"\u7ACB\u5373\u514C\u63DB"},
			"czech": {header1:"Videa, kter\u00E1 zap\u016Fsob\u00ED",header2:"Z\u00EDskejte 25% slevu na objedn\u00E1vku z\u00E1b\u011Br\u016F je\u0161t\u011B dnes",use_code:"",cta:"Uplatnit ihned"},
			"danish": {header1:"Videoer, der g\u00F8r indtryk",header2:"F\u00E5 25% i rabat p\u00E5 din bestilling af filmoptagelser i dag",use_code:"",cta:"ndl\u00F8s nu"},
			"finland": {header1:"Videoita, jotka tekev\u00E4t vaikutuksen",header2:"Saat 25 % alennuksen videomateriaalitilauksestasi t\u00E4n\u00E4\u00E4n",use_code:"",cta:"Lunasta nyt"},
			"hungary": {header1:"Vide\u00F3k, amelyek nagy hat\u00E1st gyakorolnak",header2:"25%-os engedm\u00E9ny a felv\u00E9telekb\u0151l ma",use_code:"",cta:"V\u00C1LTSA BE MOST"},
			"norway": {header1:"Videoer som gj\u00F8r inntrykk",header2:"F\u00E5 25 % rabatt p\u00E5 videobestillingen din i dag",use_code:"",cta:"L\u00F8s inn n\u00E5"},
			"polish": {header1:"Znajd\u017A idealn\u0105 muzyk\u0119",header2:"Zaoszcz\u0119d\u017A 25% na swoich utworach muzycznych ju\u017C dzi\u015B",use_code:"",cta:"SKORZYSTAJ TERAZ"},
			"russia": {header1:"\u0412\u0438\u0434\u0435\u043E, \u043A\u043E\u0442\u043E\u0440\u044B\u0435 \u043F\u0440\u043E\u0438\u0437\u0432\u043E\u0434\u044F\u0442 \u0432\u043F\u0435\u0447\u0430\u0442\u043B\u0435\u043D\u0438\u0435",header2:"25% \u0441\u043A\u0438\u0434\u043A\u0430 \u043D\u0430 \u0432\u044B\u0431\u0440\u0430\u043D\u043D\u044B\u0439 \u0432\u0430\u043C\u0438 \u0432\u0438\u0434\u0435\u043E\u0440\u044F\u0434 \u0441\u0435\u0433\u043E\u0434\u043D\u044F",use_code:"",cta:"\u0417\u0430\u0431\u0435\u0440\u0438\u0442\u0435 \u043F\u0440\u044F\u043C\u043E \u0441\u0435\u0439\u0447\u0430\u0441"},
			"sweden": {header1:"Videor som g\u00F6r ett intryck",header2:"F\u00E5 25% rabatt p\u00E5 din videobest\u00E4llning idag",use_code:"",cta:"Anv\u00E4nd nu"},
			"thai": {header1:"\u0E27\u0E34\u0E14\u0E35\u0E42\u0E2D\u0E17\u0E35\u0E48\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E1C\u0E25\u0E01\u0E23\u0E30\u0E17\u0E1A",header2:"\u0E23\u0E31\u0E1A\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 25% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E1F\u0E38\u0E15\u0E40\u0E17\u0E08\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49",use_code:"",cta:"\u0E23\u0E31\u0E1A\u0E40\u0E25\u0E22\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49"},
			"turkey": {header1:"Ak\u0131llarda kalan videolar",header2:"Video sipari\u015Finde bug\u00FCn %25 indirim kazan",use_code:"",cta:"\u015Eimdi kullan"},
			"dutch": {header1:"Video's die impact maken",header2:"Ontvang vandaag 25% korting op uw beeldmateriaal bestelling",use_code:"",cta:"Ontvang nu"},
			"italian": {header1:"Video che lasciano il segno",header2:"Ricevi subito uno sconto del 25% sul tuo ordine di filmati",use_code:"",cta:"Approfittane ora"},
			"korean": {header1:"\uD6A8\uACFC \uB9CC\uC810\uC758 \uB3D9\uC601\uC0C1\uC744 \uAD6C\uB9E4\uD558\uC138\uC694",header2:"\uC624\uB298 \uC8FC\uBB38\uD558\uBA74 25% \uD560\uC778",use_code:"",cta:"\uC9C0\uAE08 \uD61C\uD0DD\uBC1B\uAE30"},
			"espanol": {header1:"V\u00EDdeos que causan impacto",header2:"Consiga hoy 25% en su orden de v\u00EDdeo",use_code:"",cta:"Canjear ahora"},
			"french": {header1:"Des vid\u00E9os qui font de l\u2019effet",header2:"Profitez d\u00E8s aujourd\u2019hui de 25\u00A0% de r\u00E9duction sur vos vid\u00E9os",use_code:"",cta:"Profitez-en maintenant"},
			"portuguese": {header1:"Videos queles causam um impacto",header2:"Consigue 25 % de desconto de teu ordem de material hoje",use_code:"",cta:"Redimir agora"},
			"german": {header1:"Videos, die \u00FCberzeugen",header2:"Erhalten Sie heute 25\u00A0% Rabatt auf Ihr Bildmaterial",use_code:"",cta:"Jetzt einl\u00F6sen"}
		};

		usi_app.is_video = function() {
			try {
				if (location.href.indexOf("/video/") != -1 || location.href.indexOf("/video") != -1) return true;
				if (window.dataLayer != undefined) {
					for (var i=0; i<dataLayer.length; i++) {
						if (typeof(dataLayer[i].products) !== "undefined") {
							for (var j=0; j < dataLayer[i].products.length; j++) {
								if (dataLayer[i].products[j].type == "videos") {
									return true;
								}
							}
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.is_music = function() {
			try {
				if (location.href.indexOf("/music") != -1) return true;
				if (window.dataLayer != undefined) {
					for (var i = 0; i < dataLayer.length; i++) {
						if (typeof (dataLayer[i].products) !== "undefined") {
							for (var j = 0; j < dataLayer[i].products.length; j++) {
								if (dataLayer[i].products[j].type == "music") {
									return true;
								}
							}
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.is_image = function() {
			try {
				if (location.href.indexOf("/images") != -1 || location.href.indexOf("/image-photo/") != -1 || location.href.indexOf("/image-illustration/") != -1
					|| location.href.indexOf("/vectors") != -1 || location.href.indexOf("/image-vector/") != -1
					|| location.href.indexOf("/offset") != -1 || location.href.indexOf("/photos") != -1
					|| location.href.indexOf("/featured-collections") != -1 || location.href.indexOf("/photos") != -1
					|| location.href.indexOf("?image_type=") != -1 || location.href.indexOf("/category/") != -1
					|| (location.href.indexOf("/editorial/") != -1 && location.href.indexOf("video") == -1)
					|| location.href.indexOf("/explore/royalty-free-images") != -1 || location.href.indexOf("/pricing") != -1 ) return true;

				if (window.dataLayer != undefined) {
					for (var i = 0; i < dataLayer.length; i++) {
						if (typeof (dataLayer[i].productFamily) !== "undefined") {
							if (dataLayer[i].productFamily == "Monthly Subscription" || dataLayer[i].productFamily == "On Demand Subscription") {
								return true;
							}
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.save_cart = function(){
			try {
				usi_commons.log("usi_app.save_cart()");
				var cart_prefix = "usi_prod_";
				usi_cookies.flush("usi_subtotal");
				usi_cookies.flush(cart_prefix);
				usi_app.cart = {
					items: usi_app.scrape_cart(),
					subtotal: usi_app.scrape_subtotal()
				}
				usi_commons.log(usi_app.cart);

				if (typeof usi_app.cart.items != "undefined" && typeof usi_app.cart.subtotal != "undefined") {
					usi_cookies.set("usi_subtotal", usi_app.cart.subtotal, usi_cookies.expire_time.week);
					usi_app.cart.items.forEach(function(product, index){
						var prop;
						if (index >= 3) return;
						for (prop in product) {
							if (product.hasOwnProperty(prop)) {
								usi_cookies.set(cart_prefix + prop + "_" + (index + 1), product[prop], usi_cookies.expire_time.week);
							}
						}
					});

					if (usi_cookies.value_exists("usi_cart_count")) {
						usi_cookies.del("usi_cart_count");
					}
					usi_cookies.set("usi_cart_count", usi_app.cart.items.length, usi_cookies.expire_time.week);
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_subtotal = function() {
			try {
				var subtotal = document.querySelector('[data-automation="Upsell_estimatedTotal_value"]');
				if (subtotal != null) {
					subtotal = subtotal.textContent.replace(/[^0-9.]/g, '');
					usi_cookies.set("usi_subtotal", subtotal, usi_cookies.expire_time.week);
					return subtotal.replace(/[^0-9.]/g, '');
				}
				var subtotal = document.querySelector("div[data-automation='CompleteCheckout_totalPrice_div']");
				if (subtotal != null) {
					subtotal = subtotal.textContent.replace(/[^0-9.]/g, '');
					usi_cookies.set("usi_subtotal", subtotal, usi_cookies.expire_time.week);
					return subtotal.replace(/[^0-9.]/g, '');
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_cart = function() {
			try {
				return usi_dom.get_elements('[data-automation="CartBasket_itemsList_div"] [data-automation="ItemCard_container_div"]').map(function(container){
					var product = {};
					if (container.querySelector("a")) {
						product.link = container.querySelector("a").href;
						product.pid = product.link.substring(product.link.lastIndexOf("/") + 1);
					}
					if (container.querySelector("a img")) {
						product.image = container.querySelector("a img").src;
					}
					if (container.querySelector('[data-automation="ItemCard_header_title"]') != null) {
						product.name = container.querySelector('[data-automation="ItemCard_header_title"]').textContent.trim();

						if (container.querySelector('[data-automation="ItemCard_header_title"]').closest('div').textContent.includes('wav')) {
							product.type = "music";
						} else if (container.querySelector('[data-automation="ItemCard_header_title"]').closest('div').textContent.includes('mov')) {
							product.type = "video";
						}
					}
					if (container.querySelector('[data-automation="ItemCard_price"]') != null) {
						product.price = usi_dom.string_to_decimal(container.querySelector('[data-automation="ItemCard_price"]').textContent.trim());
					}

					return product;
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.apply_coupon = function() {
			try {
				usi_commons.log("usi_app.apply_coupon()");
				var coupon_input = document.querySelector("[data-automation='OrderSummary_coupon_input']");
				var coupon_button = document.querySelector("[data-automation='OrderSummary_apply_coupon_button']");
				if (coupon_input !== null && coupon_button !== null) {
					// Register something
					var customEvent = new Event('input', { bubbles: true});
					var lastValue = coupon_input.value;
					customEvent.simulated = true;
					coupon_input.value = usi_app.coupon;
					coupon_input.defaultValue = usi_app.coupon;
					var tracker = coupon_input._valueTracker;
					if (tracker) {
						tracker.setValue(lastValue);
					}
					coupon_input.dispatchEvent(customEvent);
					usi_cookies.set("usi_coupon_applied", usi_app.coupon, usi_cookies.expire_time.week);
					usi_cookies.del("usi_coupon");
					usi_app.coupon = "";
					coupon_button.disabled = false;
					coupon_button.click();
					usi_commons.log("Coupon applied");
					usi_app.boostbar.close();
				} else {
					usi_commons.log("[ error ] * * * Coupon Input not found");
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.boostbar = {
			load: function(){
				usi_commons.log("usi_app.boostbar.load()");
				if (usi_cookies.get("usi_boostbar") == "closed") return;

				var usi_boost_css = [
					'#usi_boost_close {height:100%; width:5%; right:5%; top:0; bottom:0; position:absolute; color:rgba(12,18,28,.87); font-size:2em; text-decoration:none;}',
					'#usi_boost_container {position:fixed; bottom:0; left:0; right:0; width:100%; text-align:center; font-size:1.25em; background:#fff; color:rgba(12,18,28,.87); padding:1em 2.5em; line-height: 1; z-index:2147483647;box-shadow: 0 0 5px 2px rgba(0, 0, 0, 0.33);}'
				].join('');
				usi_app.boostbar.place_css(usi_boost_css);

				var usi_boost_container = document.createElement('div');
				usi_boost_container.innerHTML = [
					'<div id="usi_boost_container">',
					'<a id="usi_boost_close" href="javascript:usi_app.boostbar.close();">&times;</a>',
					'Your coupon will be applied at checkout!',
					'</div>'
				].join('');
				document.body.appendChild(usi_boost_container);
			},
			place_css:function(css) {
				usi_commons.log("usi_app.boostbar.place_css()");
				var usi_css = document.createElement("style");
				usi_css.type = "text/css";
				if (usi_css.styleSheet) usi_css.styleSheet.cssText = css;
				else usi_css.innerHTML = css;
				document.getElementsByTagName('head')[0].appendChild(usi_css);
			},
			close: function(){
				usi_commons.log("usi_app.boostbar.close()");
				var bar = document.getElementById('usi_boost_container');
				usi_cookies.set("usi_boostbar", "closed", usi_cookies.expire_time.week);
				if (bar != null) {
					bar.parentNode.removeChild(bar);
				}
			}
		};

		usi_app.check_sub_total_price = function(check_price){

			var return_check = false;

			if(!usi_app.can_flex){
				return false;
			}
			if(usi_cookies.value_exists('usi_subtotal')){
				if(Number(usi_cookies.get("usi_subtotal")) <= check_price){
					return_check = true;
				}else{
					return_check = false;
				}
			}else {
				if (usi_app.price_cart == null || (usi_app.price_cart != null && Number(usi_app.price_cart.sub_total) <= check_price)) {
					return_check = true;
				} else {
					return_check = false;
				}
			}

			return return_check;
		};

		usi_app.check_flex_account_page = function(){
			if(usi_app.is_create_account_page && usi_app.has_flex_account_page && (!usi_app.user_status || usi_app.user_status == 'undefined')){
				return true;
			}else{
				return false;
			}
		}


		usi_app.get_order_info = function (property) {
			try {
				if (window.dataLayer != undefined) {
					for (var i in dataLayer) {
						if (dataLayer[i]["page"] != undefined && dataLayer[i]["page"].hasOwnProperty(property)) {
							return dataLayer[i]["page"][property] === "en";
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.get_user_status = function (property) {
			try {
				if (window.dataLayer != undefined) {
					for (var i in dataLayer) {
						if (dataLayer[i][property] != undefined) {
							return dataLayer[i][property];
						}
					}
				}
				return {};
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.user_data = function() {
			try {
				var user_data = "";
				if (window.dataLayer != undefined) {
					for (var i = 0; i < window.dataLayer.length; i++) {
						if (typeof(window.dataLayer[i].user) != "undefined") {
							user_data = JSON.stringify(dataLayer[i].user);
						}
					}
				}
				if (usi_cookies.get("usi_reported") == null || usi_cookies.get("usi_reported") != user_data.length) {
					usi_cookies.set("usi_reported", user_data.length, 24*60*60);
					//usi_analytics.send_page_hit("VIEW", "5698", "&user=" + encodeURIComponent(user_data));
					return true;
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.check_for_change = function(){
			try {
				if (usi_app.current_page == undefined || usi_app.current_page != location.href) {
					usi_commons.log("USI: check for change");
					usi_app.current_page = location.href;
					usi_app.main();
					usi_commons.log("USI: running main");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_ajax_cart = function(){
			usi_app.get_listen("https://www.shutterstock.com/napi/cart?application-namespace=sstk_cart&include=items%2Citems.product", usi_app.handle_ajax_response);
		}

		usi_app.get_listen = function(url, callback) {
			try {
				var options = {
					url: url,
				}
				usi_commons.log("usi_app.get_listen()");
				if (!usi_app.ajax) usi_app.ajax = {};
				usi_app.ajax[url] = new usi_ajax.get_with_options(options, callback);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.is_json = function(str) {
			try {
				JSON.parse(str);
			} catch(err) {
				return false
			}
			return true;
		};
		usi_app.handle_ajax_response = function(err, response) {
			try {
				usi_commons.log("usi_app.handle_ajax_response()");
				if (usi_app.is_json(response.responseText)) {
					var data = JSON.parse(response.responseText);
					if (data.included) {
						// Handle response
						var price_items = [];
						var cart_items = [];
						for (var i = 0; i < data.included.length; i++) {
							var item = data.included[i];
							var item_type = item.type;
							if (item_type == 'cart-items') {
								var cart_item = {};
								var item_id = item.id;
								var price_id = item.relationships.product.data.id;
								cart_item.item_id = item_id;
								cart_item.price_id = price_id;
								cart_items.push(cart_item);
							} else if (item_type == 'products') {
								var product_item = {};
								var product_id = item.id;
								var business_unit = item.attributes.businessUnit;
								var product_price = item.attributes.price;
								product_item.product_id = product_id;
								product_item.business_unit = business_unit;
								product_item.product_price = product_price;
								price_items.push(product_item);
							}
						}
						usi_app.price_cart = usi_app.build_price_chart(cart_items, price_items);
						usi_app.load();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.post_listen = function(url, callback) {
			try {
				usi_commons.log("usi_app.post_listen()");
				if (!usi_app.ajax) usi_app.ajax = {};
				usi_app.ajax[url] = new usi_ajax.listener();
				usi_app.ajax[url].register('POST', url, callback);
				usi_app.ajax[url].listen();
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.handle_ajax_response2 = function(err, response) {
			try {
				usi_commons.log("usi_app.handle_ajax_response2()");
				if (err) {
					return usi_commons.report_error(err);
				} else if (!response || !response.responseText || !usi_app.is_json(response.responseText)) {
					return usi_commons.report_error('Incorrect response');
				}
				var data = JSON.parse(response.responseText);
				usi_app.get_ajax_cart();
				// Handle response
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.build_price_chart = function(cart_items,price_items){
			usi_commons.log(cart_items);
			usi_commons.log(price_items);
			var price_cart = {};
			price_cart.items = [];
			price_cart.sub_total = 0;
			for(var i = 0; i < price_items.length; i++){
				var price_item = price_items[i];
				var price_cart_item = {};
				price_cart_item.id = price_item.product_id;
				price_cart_item.unit_price = price_item.product_price;
				price_cart_item.count = 0;
				price_cart_item.sub_total = 0;
				for(var e = 0; e < cart_items.length; e++){
					var cart_item = cart_items[e];
					if(cart_item.price_id == price_item.product_id){
						price_cart_item.count++;
					}
				}
				price_cart_item.sub_total = price_cart_item.unit_price * price_cart_item.count;
				price_cart.sub_total = price_cart.sub_total + price_cart_item.sub_total;
				price_cart.items.push(price_cart_item);
			}
			usi_commons.log(price_cart);
			return price_cart;
		}


		usi_app.session_data_callback = function() {
			usi_commons.log("usi_app.session_data_callback()");
			usi_dom.ready(function () {
				try {
					if (usi_commons.device != "mobile") {
						usi_app.country = usi_app.session_data.country;
						usi_app.force_country = usi_commons.gup_or_get_cookie('usi_force_country');
						if (usi_app.force_country != "") {
							usi_app.country = usi_app.force_country;
						}
						usi_app.suppress_app = usi_commons.gup_or_get_cookie("usi_suppress_app", usi_cookies.expire_time.minute, true) != "";
						if (usi_app.suppress_app) {
							usi_commons.log('[ usi_dom.ready ] Suppressing app file!');
						} else {
							setInterval(usi_app.check_for_change, 900);
						}
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
			});
		};

		usi_commons.load_session_data();
	} catch(err) {
		usi_commons.report_error(err);
	}
}