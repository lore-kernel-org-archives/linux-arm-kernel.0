From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 14:31:01 +0200
Subject: [PATCH 2/9] USB: move bulk of otg/otg.c to phy/phy.c
In-Reply-To: <512DFC34.30000@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-3-git-send-email-mkl@pengutronix.de>
 <512DFC34.30000@pengutronix.de>
Message-ID: <20130227123101.GL8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 01:29:40PM +0100, Marc Kleine-Budde wrote:
> On 02/27/2013 01:27 PM, Marc Kleine-Budde wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > Most of otg/otg.c is not otg specific, but phy specific, so move it
> > to the phy directory.
> > 
> > Cc: Felipe Balbi <balbi@ti.com>
> > Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Felipe, can you please review this patch and give us your Acked-by?

I will take it through my tree

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/3b5f3d2e/attachment.sig>
