From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 31 Jan 2013 10:16:01 +0800
Subject: [PATCH 1/6] USB: move bulk of otg/otg.c to phy/phy.c
In-Reply-To: <1359559782-14552-2-git-send-email-s.hauer@pengutronix.de>
References: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
 <1359559782-14552-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130131021600.GE9777@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 04:29:37PM +0100, Sascha Hauer wrote:
> Most of otg/otg.c is not otg specific, but phy specific, so move it
> to the phy directory.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Good catch, you can add Felipe Balbi <balbi@ti.com> to list, he is
the maintainer of USB PHY.

Best Regards,
Peter Chen
