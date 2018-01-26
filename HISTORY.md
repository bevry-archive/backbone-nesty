# History

## v2.0.0 2018 January 26
- `parse()` now forwards the `parse` option
    - Thanks to [dodo](https://github.com/dodo) for [pull request #1](https://github.com/bevry/backbone-nesty/pull/1)
- Now compatible with any Backbone v1 version
- Upgraded compilation from CoffeeScript v1 with CoffeeScript v2
- Now published with multiple [editions](https://github.com/bevry/editions) so you can select the best one for your environment
- Updated base files

## v1.6.0 2013 April 19
- Setting a nested ID collections over a pre-set value will now apply properly

## v1.5.0 2013 April 19
- Correctly handle setting ID indexed collections
- Added tests for `embeds` property

## v1.4.0 2013 April 18
- By default when over-writing a model attribute with a new model, we will replace the old model with the new model, rather than copying in the attributes of the new model into the old model
    - This can be turned off by using `replaceModel: false` inside your set options
- Added `isPreparedValue(key,value)` method

## v1.3.0 2013 April 17
- Can now set `strict` property by passing it as an option to the constructor
- We now dereference the `defaults` as well as the `toJSON` output
- `toJSON` output will now also have the model's id

## v1.2.0 2013 April 17
- We now dereference the `defaults` property
- Methods are now bound to the instance

## v1.1.0 2013 April 16
- If the nested object already exists, we won't over-write it but instead apply the new values to it

## v1.0.1 2013 April 10
- `toJSON()` will now use `get` on the model instead of our internal `getDeep` on attributes for fetching nested models then serialising them
- `get` will now set the value if it needed to be prepared

## v1.0.0 2013 April 10
- Initial working release

## v0.1.0 2013 April 8
- Initial non-working version
