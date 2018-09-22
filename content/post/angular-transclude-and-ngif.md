+++
categories = ["Development"]
date = "2016-04-11T18:20:52-05:00"
tags = ["angular", "javascript"]
title = "Angular transclude directive and ng-if"

+++
As I continue to dive further and further into Angular development it never ceases to amaze me how quickly I can get tripped up by directives.  This is just something I learned last week about using a custom transclude function and an `ng-if` on a directive.
<!--more-->

Originally, I had a directive that look something like this:

```javascript
angular.module('app')
  .directive('uiField', function(UiFieldService) {
    return {
      restrict: 'EA',
      template:
      `<div ng-show="field.render">
        <label for="{{field.code}}" ng-bind="field.label"></label>
        <div ng-transclude></div>
       </div>`,
      transclude: true,
      scope: {
        code: '@'
      },
      link: function(scope) {
        scope.field = UiFieldService.getField(scope.code);
      }
    };
  }
);
```

However, I wanted to make my `field` object available to the transcluded element so I can do something like this:

```html
<ui-field code="name">
  <input name="{{field.code}}" type="text" ng-model="person.name" />
</ui-field>
```

So, I changed it to use a custom transclude function like this:

```javascript
angular.module('app')
  .directive('uiField', function(UiFieldService) {
    return {
      restrict: 'EA',
      template:
      `<div ng-show="field.render">
        <label for="{{field.code}}" ng-bind="field.label"></label>
        <div ui-field-transclude></div>
       </div>`,
      transclude: true,
      scope: {
        code: '@'
      },
      link: function(scope, element, attrs, ctrl, transclude) {
        scope.field = UiFieldService.getField(scope.code);

        transclude(function(clone, transcludeScope) {
          transcludeScope.field = scope.field;
          element.find('*[ui-field-transclude]').append(clone);
        });
      }
    };
  }
);
```

This worked fine.  I wanted to change the `ng-show` in the template to an `ng-if` so that any fields not rendered are not generated at all.  Of course, after making that change then my `input` element was no longer being rendered. The problem with it is that the `ng-if` causes it's child elements to be removed so when I try to find the element with the `ui-field-tranclude` attribute, nothing is there.

After, struggling to find a solution I realized that if I was still using `ng-transclude` instead of my custom transclude function then the `ng-if` worked just fine.  So I decided to take a look at the source code for `ng-tranclude`. It turns out that if you have `transclude: true` on your directive the transclude function is available in the linking function of any child directive in your template. So, I just needed a second directive:

```javascript
angular.module('app')
  .directive('uiField', function(UiFieldService) {
    return {
      restrict: 'EA',
      template:
      `<div ng-if="field.render">
        <label for="{{field.code}}" ng-bind="field.label"></label>
        <div ui-field-transclude></div>
       </div>`,
      transclude: true,
      scope: {
        code: '@'
      },
      link: function(scope, element, attrs, ctrl, transclude) {
        scope.field = UiFieldService.getField(scope.code);
      }
    };
  }
  .directive('uiFieldTransclude', function() {
    return {
      restrict: 'EA',
      link: function(scope, element, attrs, ctrl, transclude) {
        transclude(function(clone, transcludeScope) {
          transcludeScope.field = scope.field;
          element.append(clone);
        });
      }
    };
  }
);
```