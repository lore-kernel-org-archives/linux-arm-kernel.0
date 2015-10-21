From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 21 Oct 2015 15:08:44 +0200
Subject: [PATCH] MAINTAINERS: ARM: EXYNOS: Add documentation and
 dt-bindings
In-Reply-To: <CAJKOXPdG9qd_bAPdpKQSWJ5bM_LnjQ=XcWH14sa1jo0T5b+8zQ@mail.gmail.com>
References: <1445391203-3819-1-git-send-email-k.kozlowski@samsung.com>
 <5627509E.6090503@osg.samsung.com>
 <CAJKOXPdG9qd_bAPdpKQSWJ5bM_LnjQ=XcWH14sa1jo0T5b+8zQ@mail.gmail.com>
Message-ID: <56278E5C.9040603@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/21/2015 02:43 PM, Krzysztof Kozlowski wrote:
> 2015-10-21 17:45 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>>
>> Hello Krzysztof,
>>
>> Patch looks good to me, I've only one comment.
>>
>> On 10/21/2015 03:33 AM, Krzysztof Kozlowski wrote:
>>> Extend the Samsung Exynos maintainer entry to match SoC documentation
>>> and SoC dt-bindings directories. Without that some files, like
>>> bindings/arm/samsung/pmu.txt, are not matched by existing patterns.
>>>
>>> This also may serve as a hint where new documentation and bindings (not
>>> matching specific subsystem) should be put.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Cc: Kukjin Kim <kgene@kernel.org>
>>> ---
>>>  MAINTAINERS | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b556aad90930..cad7b6b628b2 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1459,6 +1459,8 @@ F:      drivers/*/*s3c2410*
>>>  F:   drivers/*/*/*s3c2410*
>>>  F:   drivers/spi/spi-s3c*
>>>  F:   sound/soc/samsung/*
>>> +F:   Documentation/arm/Samsung/
>>
>> That there is also a Documentation/arm/Samsung-S3C24XX/ so
>> I think this should be Documentation/arm/Samsung*/ instead.
> 
> I am not sure... I think this is documentation from the Ben Dooks'
> work and there is a entry for S3C241x machines:
> SIMTEC EB2410ITX )
>

I'm not familiar with S3C241x but the EB2410ITX entry only covers
a couple of files under arch/arm/mach-s3c24xx, basically all that
are related to the BAST machine (board file and platform data).

But arch/arm/mach-s3c24* and drivers/*/*s3c2410* are covered by
the ARM/SAMSUNG entry so that's why I thought the Samsung-S3C24XX
docs should be there too since are SoC and not board specific.

It's your call but I would put it in ARM/SAMSUNG and only the file
Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt in the BAST entry.

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
