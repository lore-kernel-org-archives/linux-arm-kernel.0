From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 6 Apr 2011 14:07:43 +0800
Subject: arm: pmu: support pmu/perf on OMAP4 - booting problem on
	pandaboard
In-Reply-To: <4D9AF790.7010504@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
	<BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
	<4D99EB4B.3020303@linux.vnet.ibm.com>
	<BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
	<4D9AF790.7010504@linux.vnet.ibm.com>
Message-ID: <BANLkTikxu3DaxWZ88wgCP2cCZD=kNm-YeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Avik,

2011/4/5 Avik Sil <aviksil@linux.vnet.ibm.com>:
> Even after using ioremapped addresses in omap_writel() I'm getting the oops.
> Can you please point me to the location in mainline, where these l3 clocks
> are enabled?

I guess you can find here:

         l3_main_3_ick && l3_instr_ick: arch/arm/mach-omap2/clock44xx_data.c

the clocks are set as ENABLE_ON_INIT.

thanks,
-- 
Ming Lei
