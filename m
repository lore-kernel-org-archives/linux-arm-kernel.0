From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Dec 2010 13:37:11 +0000
Subject: [PATCH 13/14] OMAP2/3: PRCM: split OMAP2/3-specific PRCM code
	into OMAP2/3-specific files
In-Reply-To: <20101207012516.3708.87606.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012516.3708.87606.stgit@twilight.localdomain>
Message-ID: <20101207133710.GW4698@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 06:25:17PM -0700, Paul Walmsley wrote:
> In preparation for adding OMAP4-specific PRCM accessor/mutator
> functions, split the existing OMAP2/3 PRCM code into OMAP2/3-specific
> files.  Most of what was in mach-omap2/{cm,prm}.{c,h} has now been
> moved into mach-omap2/{cm,prm}2xxx_3xxx.{c,h}, since it was
> OMAP2xxx/3xxx-specific.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
