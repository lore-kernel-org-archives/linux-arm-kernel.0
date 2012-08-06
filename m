From: zonque@gmail.com (Daniel Mack)
Date: Mon, 06 Aug 2012 12:32:23 +0200
Subject: [PATCH 6/6] ARM: dts: add pinctrl in PXA DT files
In-Reply-To: <201208060844.29333.arnd@arndb.de>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
 <1343458722-17127-7-git-send-email-haojian.zhuang@gmail.com>
 <201208060844.29333.arnd@arndb.de>
Message-ID: <501F9D37.9030809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.08.2012 10:44, Arnd Bergmann wrote:
> On Saturday 28 July 2012, Haojian Zhuang wrote:
>> +Required subnode-properties:
>> +- marvell,pins : An array of strings. Each string contains the name of a pin
>> +                 or group.
>> +- marvell,function     : A string containing the name of the function to mux to the
>> +                 pin or group.
>> +- marvell,drive-strength : An integer value that means the drive strength of a
>> +                        pin.
>> +- marvell,pull-up      : The property means a pin is pull up for input.
>> +- marvell,pull-down : The property means a pin is pull down for input.
>> +- marvell,lowpower-pull-up : The property means a pin is pull up for input in
>> +                         sleep state.
>> +- marvell,lowpower-pull-down : The property means a pin is pull down for input
>> +                           in sleep state.
>> +- marvell,lowpower-drive-high : The property means a pin is driving high for
>> +                            output in sleep state.
>> +- marvell,lowpower-drive-low : The property means a pin is driving low for
>> +                           output in sleep state.
>> +- marvell,lowpower-float : The property means a pin is float in sleep state.
>> +- marvell,lowpower-zero : The property means a pin is not configured in sleep
>> +                       state.
> 
> These (or most of them) look like they are not very Marvell specific. Should
> we try to standardize the way they are set across different bindings?

Yes please. That way we also have a higher chance that implementations
on other platforms will be similar.


Daniel
