{
    "type": "Screen",
    "appBar": {
        "type": "AppBar",
        "attributes": {
            "title": "Profile"
        }
    },
    "child": {
        "type": "Form",
        "attributes": {
            "padding": 10
        },
        "children": [
            {
                "type": "Input",
                "attributes": {
                    "name": "first_name",
                    "value": "Ray",
                    "caption": "First Name",
                    "maxLength": 30
                }
            },
            {
                "type": "Input",
                "attributes": {
                    "name": "last_name",
                    "value": "Sponsible",
                    "caption": "Last Name",
                    "maxLength": 30
                }
            },
            {
                "type": "Input",
                "attributes": {
                    "name": "email",
                    "value": "ray.sponsible@gmail.com",
                    "caption": "Email *",
                    "required": true
                }
            },
            {
                "type": "Input",
                "attributes": {
                    "type": "date",
                    "name": "birth_date",
                    "caption": "Date of Birth"
                }
            },
            {
                "type": "Input",
                "attributes": {
                    "type": "Submit",
                    "name": "submit",
                    "caption": "Create Profile"
                },
                "action": {
                    "type": "Command",
                    "url": "https://myapp.herokuapp.com/commands/save-profile",
                    "prompt": {
                        "type": "Dialog",
                        "attributes": {
                            "type": "confirm",
                            "title": "Confirmation",
                            "message": "Are you sure you want to change your profile?"
                        }
                    }
                }
            }
        ]
    }
}
