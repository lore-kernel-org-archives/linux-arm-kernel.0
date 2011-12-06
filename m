From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Dec 2011 10:13:05 +0000
Subject: [PATCH v2 1/4] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111206032642.GI2980@S2100-06.ap.freescale.net>
References: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
 <1322731268-12158-2-git-send-email-shawn.guo@linaro.org>
 <20111202153637.GY8245@opensource.wolfsonmicro.com>
 <20111205064124.GC2980@S2100-06.ap.freescale.net>
 <20111205190946.GD7467@opensource.wolfsonmicro.com>
 <20111206032642.GI2980@S2100-06.ap.freescale.net>
Message-ID: <20111206101304.GA28840@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 11:26:43AM +0800, Shawn Guo wrote:
> On Mon, Dec 05, 2011 at 07:09:47PM +0000, Mark Brown wrote:

> > That doesn't answer the question - I've still no idea how the binding is
> > supposed to map the nodes contained within regulators onto the physical
> > regulators.

> And here it is.  It finds the regulator node by looking for the
> regulator name.

OK, this needs to be documented in the binding documentation - people
shouldn't need to look at the code to figure this out.
