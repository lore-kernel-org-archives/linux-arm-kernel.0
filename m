From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 1 Jun 2018 10:34:12 +0200
Subject: [PATCH v1 0/4] add mailbox support for i.MX7D
In-Reply-To: <20180601065821.28234-1-o.rempel@pengutronix.de>
References: <20180601065821.28234-1-o.rempel@pengutronix.de>
Message-ID: <20180601083411.s35c2floqdas6qni@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 08:58:17AM +0200, Oleksij Rempel wrote:
> This patches are providing support for mailbox (Messaging Unit) for
> i.MX7D. Functionality was tested on PHYTEC phyBOARD-Zeta i.MX7D with
> Linux running on all cores: ARM Cortex-A7 and ARM Cortex-M4.
> 
> Both parts of i.MX messaging Unit are visible for all CPUs available
> on i.MX7D. Communication worked independent of MU side in combination
> with CPU. For example MU-A used on ARM Cortex-A7 and MU-B used on ARM
> Cortex-M4 or other ways around.
> 
> The question to NXP developers: are there are limitations or
> recommendations about MU vs CPU combination? The i.MX7D documentation
> talks about "Processor A" and "Processor B". It is not quite clear
> what processor it actually is (A7 or M4).

Adding Dong Aisheng and NXP linux team to Cc:.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
