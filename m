From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Sun, 28 Sep 2014 10:01:10 +0000
Subject: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
In-Reply-To: <542410D3.2060507@freescale.com>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
 <542410D3.2060507@freescale.com>
Message-ID: <1760763ea8a0468e817d082f95e4016b@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Tudor Laurentiu-B10716
>Sent: Thursday, September 25, 2014 8:56 PM
>To: Lu Jingchang-B35083; mturquette at linaro.org
>Cc: Wood Scott-B07421; linuxppc-dev at lists.ozlabs.org; linux-
>kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
>CLK_OF_DECLARE support
>
>Hi Jingchang,
>
>On 09/23/2014 09:46 AM, Jingchang Lu wrote:
>> The IP is shared by PPC and ARM, this renames it to qoriq for better
>> represention, and this also adds the CLK_OF_DECLARE support for being
>> initialized by of_clk_init() on ARM.
>>
>
>I think you need to also update drivers/cpufreq/Kconfig.powerpc to use the
>renamed config option.
>

Thanks, I will update that selected config option of CLK_PPC_CORENET.

Best Regards,
Jingchang
>---
>Best Regards, Laurentiu
