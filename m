From: marex@denx.de (Marek Vasut)
Date: Tue, 8 Jan 2013 21:22:46 +0100
Subject: [PATCH] mtd: mxc_nand: Make use of supplied pinctrl data
In-Reply-To: <20130108195826.GD7360@game.jcrosoft.org>
References: <1357568885-15507-1-git-send-email-marex@denx.de>
 <20130108195826.GD7360@game.jcrosoft.org>
Message-ID: <201301082122.46815.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean-Christophe PLAGNIOL-VILLARD,

> On 15:28 Mon 07 Jan     , Marek Vasut wrote:
> > The MXC NAND driver doesn't consider the pinctrl data supplied via DT,
> > which will result in NAND pins not being properly configured.
> > 
> > Make the driver use pinctrl, but to prevent breakage on various boards,
> > do not fail if the pinctrl data are not available, only print a warning
> > message.
> 
> nack
> 
> we will at bus level

Can you please elaborate? I don't understand what you're complaining about at 
all, sorry.

Best regards,
Marek Vasut
