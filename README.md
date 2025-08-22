# discourse-custom-field-css-class

CSS Classes for Custom Fields

## Usage

### Settings

The component has one main setting: **User Field Mappings**

This is a list where each item follows the format:

```
field_key, field_value, class_name
```

- **`field_key`** corresponds to the name of a custom field. In the case of user profile fields, it **must also be [added to the `public user custom fields`](https://meta.discourse.org/t/ability-to-place-custom-fields-in-post-header/106928/2?u=jonaharagon1) site setting**. You can get the name of a user profile field by prepending `user_field_` to the field’s ID.
- **field_value** is the value of the option selected by the user in their profile.
- **class_name** is the CSS class you want to add to `<body>` if the user's profile matches these settings.

### CSS Usage

Once the classes are added to the `<body>` tag, you can use them in your CSS, for example:

```scss
body.CLASS-NAME {
  .some-selector {
    color: red;
  }
}
```

### Example Configuration

For a **multiselect** or **dropdown** user field with ID `3` and options Alpha, Beta, Gamma:

```
user_field_3, Alpha, alpha
user_field_3, Beta, beta
user_field_3, Gamma, gamma
```

This configuration would add the "alpha" CSS class to the `<body>` tag if the Alpha dropdown/multiselect option was selected in the user profile field, and the "beta" class if Beta were selected, etc.

For a **confirmation** (checkbox/boolean) field with ID `4`:

```
user_field_4, true, delta
```

This configuration would add the "delta" CSS class to the `<body>` tag if the user profile field was checked.

## Feedback

If you have issues or suggestions for this theme component, please bring them up on Discourse Meta.
