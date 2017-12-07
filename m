From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 07 Dec 2017 16:42:12 +0100
Subject: [PATCH net-next v2 5/8] net: phy: meson-gxl: detect LPA corruption
In-Reply-To: <20171207153403.GE24750@lunn.ch>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-6-jbrunet@baylibre.com>
 <20171207153403.GE24750@lunn.ch>
Message-ID: <1512661332.7042.5.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-07 at 16:34 +0100, Andrew Lunn wrote:
> On Thu, Dec 07, 2017 at 03:27:12PM +0100, Jerome Brunet wrote:
> > The purpose of this change is to fix the incorrect detection of the link
> > partner (LP) advertised capabilities which sometimes happens with this PHY
> > (roughly 1 time in a dozen)
> 
> Hi Jerome
> 
> Since this is a real fix, please send it alone. Base it on net, not
> net-next.  David will then get it applied to stable, so it will be
> backported.

I hesitated on this. For this fix to be "not too ugly" I need at least the
helper functions (patch 1 to 3) ... which are not really fixes.

Would it be Ok if send patches 1 to 5 to net ?
and 6 to 8 separately on net-next ?

> 
> Thanks
> 	Andrew
