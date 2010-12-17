From: nm@ti.com (Nishanth Menon)
Date: Fri, 17 Dec 2010 09:00:31 -0600
Subject: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addresses
In-Reply-To: <AANLkTimYoa3baXbcwOOx-xXLXiEbKmiEWj1xR3xVCC=+@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>	<1292580506-4421-3-git-send-email-j-pihet@ti.com>	<4D0B66ED.8030302@ti.com>
	<AANLkTimYoa3baXbcwOOx-xXLXiEbKmiEWj1xR3xVCC=+@mail.gmail.com>
Message-ID: <4D0B7B0F.4060304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet had written, on 12/17/2010 08:59 AM, the following:
>>>
>>> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
>>> index 68f57bb..b3f8379 100644
>>> --- a/arch/arm/mach-omap2/sdrc.h
>>> +++ b/arch/arm/mach-omap2/sdrc.h
>>> @@ -74,5 +74,4 @@ static inline u32 sms_read_reg(u16 reg)
>>>  */
>>>  #define SDRC_MPURATE_LOOPS             96
>>>  -
>> spurious change.
> Cosmetic change!
yep, does not belong to this patch :)

>> http://pastebin.mozilla.org/889933
> Nice test script btw

you are welcome, hope it is useful.

-- 
Regards,
Nishanth Menon
