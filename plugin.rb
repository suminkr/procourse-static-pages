# name: procourse-static-pages
# about: Adds the ability to create static pages for Discourse and redirects root to /page/home/10
# version: 0.1
# author: Joe Buhlig joebuhlig.com
# url: https://www.github.com/procourse/procourse-static-pages

enabled_site_setting :procourse_static_pages_enabled

add_admin_route 'procourse_static_pages.title', 'procourse-static-pages'

register_asset "stylesheets/pc-static-pages.scss"

load File.expand_path('../lib/pc_static_pages/engine.rb', __FILE__)

after_initialize do
  # 루트 경로 (/) 접근 시 /page/home/10으로 리디렉션합니다.
  Discourse::Application.routes.prepend do
    get "/" => redirect("/page/home/10")
  end

  # 기존 procourse-static-pages 플러그인 라우트 설정
  Discourse::Application.routes.append do
    get '/admin/plugins/procourse-static-pages' => 'admin/plugins#index', constraints: StaffConstraint.new
    get '/page/:slug/:id' => 'pc_static_pages/pages#show'
    get '/page/:id' => 'pc_static_pages/pages#show'
  end

  load File.expand_path('../app/jobs/onceoff/migrate_static_pages_plugin.rb', __FILE__)
end
