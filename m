From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Mon, 14 May 2018 10:37:03 +0200
Subject: [PATCH net-next v2 06/13] phy: add 2.5G SGMII mode to the
 phy_mode enum
In-Reply-To: <20180508123408.GK16141@n2100.armlinux.org.uk>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-7-antoine.tenart@bootlin.com>
 <20180508123408.GK16141@n2100.armlinux.org.uk>
Message-ID: <20180514083703.GG24660@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, May 08, 2018 at 01:34:08PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 04, 2018 at 03:56:36PM +0200, Antoine Tenart wrote:
> > This patch adds one more generic PHY mode to the phy_mode enum, to allow
> > configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
> > callback.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Would it be possible to get the 2.5G SGMII comphy support merged
> ahead of the rest of this series please - I don't think there's been
> any objections to it, and having it in mainline would then mean I can
> drop the Marvell Comphy code from my tree and transition to the bootlin
> Comphy code instead.
> 
> Of course, the perfect solution would be to get the whole series merged,
> but I'm just thinking about the situation where we're still discussing
> points when the next merge window opens.

That would be great, and there are no dependency issue if patches 6 and
7 are taken ahead.

Kishon: since there are no objection to these two phy patches, could you
take them?

Thanks!
Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
