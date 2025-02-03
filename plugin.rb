# name: procourse-static-pages
# about: Adds the ability to create static pages for Discourse and renders the content of /page/home/10 directly on /
# version: 0.1
# author: Joe Buhlig joebuhlig.com
# url: https://www.github.com/procourse/procourse-static-pages

enabled_site_setting :procourse_static_pages_enabled

add_admin_route 'procourse_static_pages.title', 'procourse-static-pages'

register_asset "stylesheets/pc-static-pages.scss"
register_asset "javascripts/update-logo-link.js"  # 메인로고 링크 변경용 스크립트

load File.expand_path('../lib/pc_static_pages/engine.rb', __FILE__)

after_initialize do
  # 루트 URL (/) 접근 시 pc_static_pages/pages#show 액션을 호출하여
  # 기본 파라미터 { slug: "home", id: "10" }를 전달하고 직접 렌더링합니다.
  Discourse::Application.routes.prepend do
    get "/" => "pc_static_pages/pages#show", defaults: { slug: "home", id: "10" }
  end

  # 기존 procourse-static-pages 플러그인 라우트 설정 유지
  Discourse::Application.routes.append do
    get '/admin/plugins/procourse-static-pages' => 'admin/plugins#index', constraints: StaffConstraint.new
    get '/page/:slug/:id' => 'pc_static_pages/pages#show'
    get '/page/:id' => 'pc_static_pages/pages#show'
  end

  load File.expand_path('../app/jobs/onceoff/migrate_static_pages_plugin.rb', __FILE__)
end
