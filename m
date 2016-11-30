From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 30 Nov 2016 09:41:32 -0300
Subject: [PATCH] watchdog: meson: Remove unneeded platform MODULE_ALIAS
In-Reply-To: <66487a0e-1d20-519f-6cbf-645f8bfd33da@roeck-us.net>
References: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
 <20161020222833.GA27421@roeck-us.net>
 <d7149198-b513-4022-5fbc-10067d420191@osg.samsung.com>
 <66487a0e-1d20-519f-6cbf-645f8bfd33da@roeck-us.net>
Message-ID: <ef0f36c3-a36b-b01d-f4ef-07f89f3320c3@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Guenter,

On 11/30/2016 07:59 AM, Guenter Roeck wrote:
> On 11/29/2016 06:57 AM, Javier Martinez Canillas wrote:
>> Hello Wim,
>>
>> On 10/20/2016 07:28 PM, Guenter Roeck wrote:
>>> On Wed, Oct 19, 2016 at 04:49:42PM -0300, Javier Martinez Canillas wrote:
>>>> The Amlogic Meson is a DT-only platform, which means the devices are
>>>> registered via OF and not using the legacy platform devices support.
>>>>
>>>> So there's no need to have a MODULE_ALIAS("platform:meson-gxbb-wdt")
>>>> since the reported uevent MODALIAS to user-space will be the OF one.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>
>> Any comments about this patch? There are other two similar fixes for
>> watchdog drivers that were also reviewed by Guenter but never picked:
>>
>> https://lkml.org/lkml/2016/10/14/412
>> https://lkml.org/lkml/2016/10/14/413
>>
>> Best regards,
>>
> The patches are all in my watchdog-next branch, so Wim will hopefully
> pick them up for the next release.
>

Great, thanks a lot for the info.
 
> Guenter
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
