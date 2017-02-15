From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 15 Feb 2017 15:08:32 +0800
Subject: [PATCH v2 1/4] dt-bindings: add multidomain support to i.MX GPC
 DT binding
In-Reply-To: <1486741439.3879.7.camel@pengutronix.de>
References: <20170127183728.26701-1-l.stach@pengutronix.de>
 <1486741439.3879.7.camel@pengutronix.de>
Message-ID: <20170215070830.GA8398@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 04:43:59PM +0100, Lucas Stach wrote:
> Hi Shawn,
> 
> are you willing to take this series through your tree or do you think we
> need to get this in via some other tree?

I'm willing to take it.  But I don't think it's been ready yet.  Since
you insist on keeping the .remove hook for both imx_gpc_driver and
imx_pgc_power_domain_driver, did you actually test it with manually
bind/unbind the drivers?  I tested it a bit and found it doesn't work
well for me.

Also, there is a comment from Andrey that is not responded.

Shawn

> It would be good to queue this up somewhere as a reference, as I have
> some upcoming work for MX6SX and MX6QP, which depends on this series.
