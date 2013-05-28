From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 May 2013 08:43:27 +0200
Subject: [PATCH v4 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <1369722012-6915-2-git-send-email-b32955@freescale.com>
References: <1369722012-6915-1-git-send-email-b32955@freescale.com>
 <1369722012-6915-2-git-send-email-b32955@freescale.com>
Message-ID: <20130528064327.GT32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 02:20:07PM +0800, Huang Shijie wrote:
> The WEIM(Wireless External Interface Module) works like a bus.
> You can attach many different devices on it, such as NOR, onenand.
> 
> In the case of i.MX6q-sabreauto, the NOR is connected to WEIM.
> 
> This patch also adds the devicetree binding document.
> The driver only works when the devicetree is enabled.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Looks good to me now. Thanks for working on this.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
