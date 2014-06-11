From: hs@denx.de (Heiko Schocher)
Date: Wed, 11 Jun 2014 14:15:06 +0200
Subject: [RFC PATCH] input, touch, atmel_mxt_ts: use atmel driver
In-Reply-To: <5398465B.7060101@itdev.co.uk>
References: <1402468526-9165-1-git-send-email-hs@denx.de>
 <5398465B.7060101@itdev.co.uk>
Message-ID: <5398484A.9090904@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nick,

Am 11.06.2014 14:06, schrieb Nick Dyer:
> Heiko Schocher wrote:
>> try to bring the driver from
>> https://github.com/ndyer/linux for-next
>>
>> to mainline. Post this as a RFC, to see if this is possible...
>>
>> based on:
>> commit dda0a5570574cfe467c1c794cf7a17e1d742ec02 ("Input:
>> atmel_mxt_ts - implement improved debug message interface")
>>
>> from Nick Dyer<nick.dyer@itdev.co.uk>
>>
>> added:
>> - remove some (not all) checkpatch warnings
>> - Add support for voltage regulator
>> - Add support for Device Tree support
>
> My thinking has been that the maintainers will more likely accept a series
> of small patches than to make such a huge change to the entire driver, my
> for-next tree is where I'm working on this, and I plan to post another set
> of 15 patches soon, when I've fixed up some issues to do with probe/remove
> cycles.

Sound good!

> You should note that my for-next branch has moved on slightly since you
> have taken this, because I have implemented device tree support and changed
> the config download to use the request_firmware_async() function.

Oh, I take a look at this, thanks!

> Your device tree stuff for mach-goni.c looks really useful, however - if
> you can send me a patch for that against my current for-next branch I can
> include it with my version of the device tree support.

Ok, I send you this ASAP.

Thanks for this info.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
