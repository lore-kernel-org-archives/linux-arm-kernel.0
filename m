From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Sep 2009 10:34:58 +0100
Subject: ARM Cortex-based multi-core support?
In-Reply-To: <000601ca312f$16046090$420d21b0$%yang@samsung.com>
References: <008d01ca3128$0b012e00$21038a00$%yang@samsung.com>
	<1252486591.24414.1.camel@pc1117.cambridge.arm.com>
	<000601ca312f$16046090$420d21b0$%yang@samsung.com>
Message-ID: <1252488898.24414.6.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-09-09 at 18:22 +0900, Jinsung Yang wrote:
> > On Wed, 2009-09-09 at 17:32 +0900, Jinsung Yang wrote:
> > > I'm researching that the latest kernel can support ARM cortex based
> > > multi-core platform..
> > > First, just I need to know current status.. someone knows?
> > 
> > AFAICT, it's all supported and works fine (with a few minor issues like
> > the recent thread on non position-independent dynamic shared objects, if
> > your toolchain generates such things).
> 
> Which platform codes are valuable for reference in the mainline?

Currently it's arch/arm/mach-realview/* and
arch/arm/mach-omap2/omap-*smp.c. There are other files in
arch/arm/kernel like SCU support and local timers (smp_scu, smp_twd).

-- 
Catalin
