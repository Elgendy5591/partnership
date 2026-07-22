// Minimal service worker so the app is installable as a PWA / APK.
const CACHE = "partnership-v1";
self.addEventListener("install", (e) => { self.skipWaiting(); });
self.addEventListener("activate", (e) => { self.clients.claim(); });
self.addEventListener("fetch", (e) => {
  // Network-first so data always stays fresh; fall back to cache if offline.
  e.respondWith(
    fetch(e.request).then((res) => {
      const copy = res.clone();
      caches.open(CACHE).then((c) => { try { c.put(e.request, copy); } catch (err) {} });
      return res;
    }).catch(() => caches.match(e.request))
  );
});
