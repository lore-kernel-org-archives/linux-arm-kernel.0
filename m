From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 5 Apr 2011 10:03:36 +0800
Subject: arm: pmu: support pmu/perf on OMAP4 - booting problem on
	pandaboard
In-Reply-To: <4D99EB4B.3020303@linux.vnet.ibm.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
	<BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
	<4D99D251.6000901@linux.vnet.ibm.com>
	<BANLkTikmC_OT5TsN_jfVoUjvvcSsR2p3HA@mail.gmail.com>
	<4D99EB4B.3020303@linux.vnet.ibm.com>
Message-ID: <BANLkTinQ-QQ7zu2KrhhhdWwnzo=a-KynoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2011/4/5 Avik Sil <aviksil@linux.vnet.ibm.com>:
> #define OMAP4430_CM_L3INSTR_L3_3_CLKCTRL
> OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_INST, 0x0720)
> [...]
>
> Should I use those identifier instead?

Yes, seems right, but you need to use the ioremap addresses of the identifiers.

> Are there other definitions for the identifiers you have used?

As I said  before, these are not needed for mainline, so I didn't try these.


thanks,
-- 
Ming Lei
