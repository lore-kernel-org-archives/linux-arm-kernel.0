From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Dec 2011 19:09:47 +0000
Subject: [PATCH v2 1/4] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111205064124.GC2980@S2100-06.ap.freescale.net>
References: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
 <1322731268-12158-2-git-send-email-shawn.guo@linaro.org>
 <20111202153637.GY8245@opensource.wolfsonmicro.com>
 <20111205064124.GC2980@S2100-06.ap.freescale.net>
Message-ID: <20111205190946.GD7467@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 02:41:24PM +0800, Shawn Guo wrote:
> On Fri, Dec 02, 2011 at 03:36:38PM +0000, Mark Brown wrote:
> > On Thu, Dec 01, 2011 at 05:21:05PM +0800, Shawn Guo wrote:

> > > +Sub-nodes:
> > > +- regulators : Contain the regulator nodes.  The bindings details of individual
> > > +  regulator node can be found in:
> > > +  Documentation/devicetree/bindings/regulator/regulator.txt

> > How does the driver figure out which regulators map onto which subnodes?

> There should only be one sub-node named 'regulators', otherwise, DTC
> will report ERROR (duplicate_node_names).

That doesn't answer the question - I've still no idea how the binding is
supposed to map the nodes contained within regulators onto the physical
regulators.
