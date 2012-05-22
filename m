From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 07:22:43 +0200
Subject: [PATCH v2 08/12] ARM: imx6q: add usbphy clocks
In-Reply-To: <20120522044515.GK8140@S2101-09.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205220632.13896.marex@denx.de>
 <20120522044515.GK8140@S2101-09.ap.freescale.net>
Message-ID: <201205220722.43899.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, May 22, 2012 at 06:32:13AM +0200, Marek Vasut wrote:
> > Dear Richard Zhao,
> > 
> > Maybe reorder this so it's in before the PHY driver?
> 
> It should not matter, as I suppose all those "usb: ..." patches will
> go via usb tree, while all those "ARM: ..." will go via arm-soc tree.

It's easier to bisect, but ok.

Best regards,
Marek Vasut
