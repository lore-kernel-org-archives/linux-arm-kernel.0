From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 3 Feb 2016 12:30:36 +1100
Subject: [linux-sunxi] [PATCH 01/11] MAINTAINERS: Add entry for X-Powers
 AXP family PMIC drivers
In-Reply-To: <1454462910.7291.53.camel@perches.com>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-2-git-send-email-wens@csie.org>
 <CAGRGNgVxan9RCsLFW9hHWcdW+Rd_SgVG95H-yQg213g-YeE6Ug@mail.gmail.com>
 <1454462910.7291.53.camel@perches.com>
Message-ID: <CAGRGNgXf-dvWWmyRMjgbVdnprg+fzDhbMeX7-6nZ-+LQ1J+ghA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Wed, Feb 3, 2016 at 12:28 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2016-02-03 at 11:19 +1100, Julian Calaby wrote:
>> On Tue, Feb 2, 2016 at 9:27 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> > Add an entry for X-Powers AXP family PMIC drivers and list myself
>> > as maintainer.
> []
>> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> > @@ -11941,6 +11941,12 @@ F:     include/linux/workqueue.h
>> >  F:     kernel/workqueue.c
>> >  F:     Documentation/workqueue.txt
>> >
>> > +X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS
>> > +M:     Chen-Yu Tsai <wens@csie.org>
>> > +L:     linux-kernel at vger.kernel.org
>> > +S:     Maintained
>> > +N:     axp[128]
>>
>> Should you list the files maintained and this list also?
>
> This "N:" pattern is kind of a wildcard.
>
> The difference between F: and N: is that git history
> is also used by default for files that match.
>
> There are no files in -next today that match "*axp8*"
> Dunno if this patchset added any.
>
> This matches:
>
>     $ git ls-files | grep "axp[128]"
>     Documentation/devicetree/bindings/mfd/axp20x.txt
>     Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
>     arch/arm/boot/dts/axp152.dtsi
>     arch/arm/boot/dts/axp209.dtsi
>     arch/arm/boot/dts/axp22x.dtsi
>     drivers/extcon/extcon-axp288.c
>     drivers/iio/adc/axp288_adc.c
>     drivers/input/misc/axp20x-pek.c
>     drivers/mfd/axp20x.c
>     drivers/power/axp20x_usb_power.c
>     drivers/power/axp288_charger.c
>     drivers/power/axp288_fuel_gauge.c
>     drivers/regulator/axp20x-regulator.c
>     include/linux/mfd/axp20x.h
>
> Are all these files appropriate?
>

I didn't know about the "N:" tag, and consequently I retract my comment.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
