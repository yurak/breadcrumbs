# README #

= Breadcrumbs

### What is this repository for? ###

* Builder for CRUD and custom breadcrumbs with a bunch of helper methods
* 0.0.1


### How do I get set up? ###

* Just include `Breadcrumbs::Helpers` into your `ApplicationHelper`.

* intialize class in apllication controller
```
  def set_breadcrumbs
    Breadcrumbs::CRUDCreator.prepare_params(self, @parent, breadcrumbs_nested: boolean)
  end
```
* set `helper_method :set_breadcrumbs`

in view, for example `application` layout
call
```
  render_breadcrumbs
```
* set title in localization .yml(`en.yml`) or @page_title_text in view (if it is not index action)

### Custom breadcrumbs
* set custom breadcrumbs in controller:
* define private method
```
def set_breadcrumbs
  [ { title: 'Title', url: [:resource] }, { title: title2, url: [:resource2] } ]
end
```
### Who do I talk to? ###

* https://github.com/yurakuzh
* https://bitbucket.org/ykuzhiy
