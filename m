From: finn@uni-bremen.de (Finn Hoffmann)
Date: Thu, 01 Aug 2013 22:43:48 +0200
Subject: NSA310 + DT
In-Reply-To: <20130801160414.GI19725@lunn.ch>
References: <20130730191943.49f8070c@skate> <20130730183610.GT24782@lunn.ch>
 <51F814A0.2050403@uni-bremen.de> <20130730232316.10dc7019@skate>
 <20130731111414.47e7670b@skate> <51F8DC3A.6010007@uni-bremen.de>
 <20130731115108.21c043fd@skate> <51F8F7E3.9090404@uni-bremen.de>
 <20130731164512.GB19725@lunn.ch> <51FA15F3.7050708@uni-bremen.de>
 <20130801160414.GI19725@lunn.ch>
Message-ID: <51FAC884.2070805@uni-bremen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 01.08.2013 18:04, schrieb Andrew Lunn:
>> The LED's on after kernel is loaded, while starting up does not work.
>>             pmx_led_sys_green: pmx-led-sys-green {
>>                  marvell,pins = "mpp28";
>>                  marvell,function = "gpio";
>>                  linux,default-trigger = "heartbeat";
>>                  brightness = <255>;
>>              };
>> I first tried default-trigger, then I added brightness additionally
>> but LED's wont turn on.
> Can you manually turn the LED on, using /sys/class/led/.../brightness?
> It could be we have the wrong GPIO line for the led. It would be good
> if you could test them all, not just this one led.
>
All LED's work via brightness and trigger default-on.
>> There is no sata hdd trigger and nand-disk does not trigger on sata
>> hdd activity.
> They are out of tree patches. There was some discussion about SATA led
> activity maybe 6 to 9 months ago. Maybe you can see why the suggested
> patches got rejected. If i remember correctly, it was because they are
> in the hot path.
>
>     Andrew
On a quick look I have not found it but it is not that important for me.

Finn
