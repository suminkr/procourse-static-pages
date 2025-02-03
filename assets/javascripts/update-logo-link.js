// javascripts/update-logo-link.js
// 이 스크립트는 디스코스 메인로고(.brand 클래스)의 href 속성을 "/"로 변경합니다.
(function() {
  function updateLogoLink() {
    var logoLink = document.querySelector('.brand');
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
