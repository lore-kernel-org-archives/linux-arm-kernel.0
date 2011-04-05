From: aviksil@linux.vnet.ibm.com (Avik Sil)
Date: Tue, 05 Apr 2011 16:35:52 +0530
Subject: arm: pmu: support pmu/perf on OMAP4 - booting problem on
	pandaboard
In-Reply-To: <BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
	<BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
	<4D99EB4B.3020303@linux.vnet.ibm.com>
	<BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
Message-ID: <4D9AF790.7010504@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 April 2011 07:33 AM, Ming Lei wrote:
> Hi,
>
> 2011/4/5 Avik Sil<aviksil@linux.vnet.ibm.com>:
>> #define OMAP4430_CM_L3INSTR_L3_3_CLKCTRL
>> OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_INST, 0x0720)
>> [...]
>>
>> Should I use those identifier instead?
>
> Yes, seems right, but you need to use the ioremap addresses of the identifiers.
>
Even after using ioremapped addresses in omap_writel() I'm getting the 
oops. Can you please point me to the location in mainline, where these 
l3 clocks are enabled?

Regards,
Avik
>> Are there other definitions for the identifiers you have used?
>
> As I said  before, these are not needed for mainline, so I didn't try these.
>
>
> thanks,
