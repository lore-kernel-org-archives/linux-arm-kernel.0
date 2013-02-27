From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 14:32:53 +0200
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <512DFC86.4090607@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-4-git-send-email-mkl@pengutronix.de>
 <512DFC86.4090607@pengutronix.de>
Message-ID: <20130227123253.GO8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 01:31:02PM +0100, Marc Kleine-Budde wrote:
> On 02/27/2013 01:27 PM, Marc Kleine-Budde wrote:
> > From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > 
> > This adds two little devicetree helper functions for determining the dr_mode
> > (host, peripheral, otg, dual-role) and phy_type (utmi, ulpi,...) from the
> > devicetree.
> > 
> > Cc: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Felipe, same here. Your Acked-by is appreciated.

likewise, I'll take it through my tree

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/dd25267d/attachment.sig>
