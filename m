From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 18 Jul 2013 19:59:18 +0800
Subject: [RFC] Split i.MX pinctrl groups
In-Reply-To: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
References: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130718115915.GB16328@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 09:46:07AM +0200, Sascha Hauer wrote:
> We currently introduce completely new pinctrl groups for each slight
> variant of the pinctrl setup of a device. For several devices the
> groups can be split into smaller groups to increase the flexibility
> and to reduce the devicetree sizes (both source and dtb).
> 
> For example SDHC controller groups can be split into a base group
> and an 8bit extension. The FEC groups can be split into base group
> and several MDIO groups. The UARTs can be split into a base group
> and RTS/CTS extensions.
> 
> Doing this makes the group names more obvious. Instead of having
> just index _1, _2 and so on we now have base_1, 8bit_1.
> 
> This is not meant for inclusion right now, just some preliminary
> patches to demonstrate the idea to see if this is acceptable/desired.

Yes, it makes sense to me.

Shawn
