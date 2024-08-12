'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e60b936756b94f8f0f8ab9511f57e132",
"assets/AssetManifest.bin.json": "a4cc24ed53a790c9f93cc25854fb0795",
"assets/AssetManifest.json": "f3e70cd201bc5cec06edeaebfa2e7175",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "fdb97014259f52d5f36ce84069bd2932",
"assets/images/1.png": "cf2982a8f74e6e7a883b28e90ad4b634",
"assets/images/background.jpg": "80b3cdefc2b339f1e39485563925c1c5",
"assets/images/facebook.png": "3a104631fd8446e5f6f571998dce6a08",
"assets/images/fond.png": "10d7c93f07a95aa92d87f372a624b68a",
"assets/images/fondo.png": "8e7cb174b9f8f4ea879677f9f33b025c",
"assets/images/fondo1.jpg": "e527863a439aad4835e516be1f97d2cf",
"assets/images/fondo2.jpg": "4a6cb46ebb32a83d318dc49030ab4717",
"assets/images/fondo3.jpg": "38a5c6eb8c8e477a0871d0dcd7c72f25",
"assets/images/fondo4.jpg": "44e7c5a8378318a48c6a076d7ab4626c",
"assets/images/fondo5.jpg": "18993f313e43a46d0bbf5a1132b7173f",
"assets/images/fondo6.jpg": "b134a243d3cae4ea09743a04b210a9c7",
"assets/images/fondo7.jpg": "92552a8c907e6a4af77dfad4a72d460e",
"assets/images/fondom.jpg": "af8e791211dc9e3f04b3071c6a8176aa",
"assets/images/img1.png": "52d03dbda5971929a6a6b38585c249ad",
"assets/images/img2.png": "9765b9a58c34ab406481996f80d9b510",
"assets/images/img3.png": "b769f4e0d22219a688ad63ddef19a2d4",
"assets/images/img4.png": "d44b3d988fef266411a1815885cff959",
"assets/images/instagram.png": "1a8d98fcb5c50410b878ff64c77a9057",
"assets/images/jugocod.png": "96300598f84f84a5d22a4da140bf4ac0",
"assets/images/jugos.png": "b898c339f0b1c6b2fd68e22c4b037888",
"assets/images/logo.png": "53df36852a17cb0250c618aa76a38b48",
"assets/images/logo2.png": "80ec7686e68622a1f157736027a79652",
"assets/images/p1.png": "20404a74cfa371e14115eeb8856adcdd",
"assets/images/p2.png": "bfd083d225c8d3e826a5263521bd10e7",
"assets/images/pngtree-black-and-white-circular-social-media-icons-png-image_3571779.jpg": "b766d61687b7c08fde77f2bec132b678",
"assets/images/pre1.png": "b03d1ddca4e2156199d0b21793f364e8",
"assets/images/promo.png": "470a958758ed3fc2ed4f75b3395b5896",
"assets/images/tiktok.png": "59652338687aacff86f21a9cd2aacad2",
"assets/images/tito.png": "32af3382ce9fdda81072eec4fac08c3f",
"assets/images/youtube.png": "242bbf382d58b0c0fae802ea146bdb3e",
"assets/images/yt.png": "fc11cbb251a5f95867e78d6765e8c9af",
"assets/NOTICES": "ccb778f4d23a8c001055df9d3c040bf9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"flutter_bootstrap.js": "9bf280fe69fd04d09ba913e518eacee3",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "18aaf2e497fd84025c8e0d56b518d072",
"/": "18aaf2e497fd84025c8e0d56b518d072",
"main.dart.js": "81ac27d21293301826c3cb770aeb2469",
"manifest.json": "ba86fbd13a2cda7beea487c3d68b937d",
"version.json": "85c151ddf57e6e3d7929177dd1a665c5"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
