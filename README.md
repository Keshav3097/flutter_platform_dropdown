# Flutter Platform Dropdown

This does make Flutter Framework complicated dropdown button less complicated and provide default os dropdown behaviour

# How to Use
```          
PlatformDropdown(
            width: 200,
            selectedValue: selectedItem,
            items: list,
            onChange: (val)
            {
                setState(() {
                  selectedItem = val;
                });
            }
        )
```

## Android Dropdown
![drop-down-list](https://github.com/Keshav3097/flutter_platform_dropdown/blob/master/android.png)

## iOS Dropdown
![drop-down-list](https://github.com/Keshav3097/flutter_platform_dropdown/blob/master/ios.png)