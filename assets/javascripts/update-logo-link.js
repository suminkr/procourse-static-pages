// javascripts/update-logo-link.js
// 이 스크립트는 메인 로고의 링크(href)를 "/"로 설정하여,
// 로고 클릭 시 루트 URL로 이동하도록 보장합니다.
(function() {
  function updateLogoLink() {
    var logoLink = document.querySelector('a[href="/"]');
    if (logoLink) {
      logoLink.setAttribute('href', '/');
    }
  }

  if (document.readyState !== 'loading') {
    updateLogoLink();
  } else {
    document.addEventListener('DOMContentLoaded', updateLogoLink);
  }
})();
