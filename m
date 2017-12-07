From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 07 Dec 2017 17:22:31 +0100
Subject: [PATCH net-next v2 5/8] net: phy: meson-gxl: detect LPA corruption
In-Reply-To: <20171207161248.GN24750@lunn.ch>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-6-jbrunet@baylibre.com>
 <20171207153403.GE24750@lunn.ch> <1512661332.7042.5.camel@baylibre.com>
 <20171207161248.GN24750@lunn.ch>
Message-ID: <1512663751.7042.22.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-07 at 17:12 +0100, Andrew Lunn wrote:
> > Would it be Ok if send patches 1 to 5 to net ?
> > and 6 to 8 separately on net-next ?
> 
> No. The rules for stable is that a patch must really fix something and
> be minimal.
> 
> Documentation/process/stable-kernel-rules.rst 
> 
> What might be best is to develop a minimal, but ugly patch for stable.
> Get it applied. Around a week later, net will be merged into
> net-next. You can then have a 'revert' patch, followed by this series
> making it nice and clean.

Looks like a plan. Will do.
Thanks Andrew.

> 
>        Andrew
