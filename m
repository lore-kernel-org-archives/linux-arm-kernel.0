From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Fri, 25 Nov 2016 12:17:53 +0300
Subject: [PATCH 7/9] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <1800621.EhepfMxccR@diego>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
 <1479922177-20136-7-git-send-email-al.kochet@gmail.com>
 <FFD6E644-F68B-4880-BC76-88F6063D070E@gmail.com> <1800621.EhepfMxccR@diego>
Message-ID: <3FBBE6BD-3090-40AE-A4C7-5035D75A0F4C@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko!

> 24 ????. 2016 ?., ? 15:17, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
> When touching devicetree-properties, please also adapt the binding document
> 	Documentation/devicetree/bindings/timer,rockchip,rk-timer.txt
> in this case and also include the devicetree maintainers.

Could you please clarify, i should send whole patch series and include devicetree maintainers
for whole patch series or i should send devicetree patches separately?


> 24 ????. 2016 ?., ? 16:21, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
> correct, use both but also update the binding, like 
> mmc/rockchip-dw-mshc.txt does.

Here devicetree patch for this:
http://www.spinics.net/lists/devicetree/msg152246.html


> 24 ????. 2016 ?., ? 17:32, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
>> I may suggest such solution here: if I want clocksource, I have to declare
>> two timer in device tree. First probed timer would be clockevent and second
>> one would be clocksource. All other timers will be ignored. Is that
>> solution good?
> 
> yep, sounds good, especially as with your patch 9/9 you already declare these 
> necessary timers.
> 
>> If I want one timer and want it be clocksource not clockevent how that
>> situation should be configured? Device tree not good for this. Kconfig not
>> good. Pass that configuration on kernel command line?
> 
> simply ignore that case :-)


Here devicetree patch for this:
http://www.spinics.net/lists/devicetree/msg152247.html

And I?ll going to resend new patch series with discussed modifications.
It will contain only rk_timer and dts modifications.
I have to do more tests.

Regards,
Alexander.
