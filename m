From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 13 Jul 2015 17:07:32 +0200
Subject: [PATCH] rtc: snvs: select option REGMAP_MMIO
In-Reply-To: <CAHrpEqSi=BPuZrqSvozvggAFsnXy2DqnfkzP5dpsP2cShzM7Hg@mail.gmail.com>
References: <1436775075-15037-1-git-send-email-shawnguo@kernel.org>
 <CAHrpEqSi=BPuZrqSvozvggAFsnXy2DqnfkzP5dpsP2cShzM7Hg@mail.gmail.com>
Message-ID: <20150713150732.GC20482@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/2015 at 09:48:33 -0500, Zhi Li wrote :
> On Mon, Jul 13, 2015 at 3:11 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > Select REGMAP_MMIO to fix the following build error seen with x86_64
> > randconfig.
> >
> >   drivers/built-in.o: In function `snvs_rtc_probe':
> > rtc-snvs.c:(.text+0x567730): undefined reference to `devm_regmap_init_mmio_clk'
> >
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> 
> Acked-by: Frank Li <Frank.Li@freescale.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
