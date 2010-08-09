From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 09 Aug 2010 19:43:10 +0900
Subject: [GIT PULL] Samsung S5P updates for 2.6.36 merge window
In-Reply-To: <20100809103337.GA12833@n2100.arm.linux.org.uk>
References: <017201cb37ac$9979a5a0$cc6cf0e0$%kim@samsung.com>
	<20100809103337.GA12833@n2100.arm.linux.org.uk>
Message-ID: <017501cb37af$abf7f670$03e7e350$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Mon, Aug 09, 2010 at 07:21:11PM +0900, Kukjin Kim wrote:
> >  arch/arm/configs/s5pc110_defconfig               |   66 -
> >  arch/arm/configs/s5pv210_defconfig               |    5 +
> 
> What are these changes?

Hi,

Removed s5pc110_defconfig...because updated s5pv210_defconfig can cover it.

I think this is reasonable even though there is some issue about ARM
defconfig ;-)
Because this can remove redundant defconfig...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
