From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Dec 2010 05:23:46 -0600
Subject: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
In-Reply-To: <c8819161924787cb5de43492278c4e36@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-5-git-send-email-nm@ti.com>
	<c8819161924787cb5de43492278c4e36@mail.gmail.com>
Message-ID: <4D0F3CC2.3010407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar wrote, on 12/20/2010 12:59 AM:
[..]
>> index 3fbd1e5..cc3507b 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -45,6 +45,8 @@
>>   #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
>>   #define SRAM_BASE_P		0x40200000
>>   #define CONTROL_STAT		0x480022F0
>> +#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
>> +					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
> Just a clarification. This register is not part of HW SAR SCM
> Registers, right ?
Right.

[..]
-- 
Regards,
Nishanth Menon
