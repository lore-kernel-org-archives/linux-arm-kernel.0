From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 May 2016 09:57:19 -0700
Subject: Regression: next-20160518: Clk? on BeagleBoard-X15
In-Reply-To: <573DDFE6.8010209@ti.com>
References: <573DDFE6.8010209@ti.com>
Message-ID: <20160519165719.GW5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160519 08:48]:
> I have'nt bisected yet, but the platform seems to have booted on
> next-20160517
> https://github.com/nmenon/kernel-test-logs/blob/next-20160517/omap2plus_defconfig/am57xx-evm.txt
> 
> https://github.com/nmenon/kernel-test-logs/blob/next-20160518/omap2plus_defconfig/am57xx-evm.txt

Seems to be commit ac78f9bdcf38 ("drivers/of: Fix depth when
unflattening devicetree").

Rob, you need to start playing golf or something between -rc6 and
the end of the merge window or something :)

Regards,

Tony
