From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 5 Sep 2016 01:31:22 +0200
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: Build Atmel maXTouch
 driver as a module
In-Reply-To: <7304023.0tarkq2cRD@wuerfel>
References: <1471360094-27637-1-git-send-email-javier@osg.samsung.com>
 <7304023.0tarkq2cRD@wuerfel>
Message-ID: <d1992291-d314-0a08-bbb2-a1682bd126f8@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 09/02/2016 05:38 PM, Arnd Bergmann wrote:
> On Tuesday, August 16, 2016 11:08:14 AM CEST Javier Martinez Canillas wrote:
>> The driver is for a trackpad device so is not needed for booting and
>> makes more sense to have it as module to reduce the kernel image size.
>>
>> It was probably enabled as built-in because module autoload was not
>> working when the I2C device was registered by OF but this got fixed
>> in commit b7d21058b40b ("Input: atmel_mxt_ts - add maxtouch to I2C
>> table for module autoload") so it's safe to enable as a module now.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
> 
> Applied to next/defconfig.
> 

Thanks.

> My preferred way is to get defconfig updates forwarded by the platform
> maintainers that are interested, but this seems to apply to multiple
> platforms, so I'm not asking you to pick one to resend it to.
> 

Yes. I usually route defconfig patches through a platform maintainer, but as
you said, this driver is used by different platforms so I decided to send it
to you directly since I didn't know which platform to choose.

Sorry if that caused inconveniences.

> 	Arnd
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
