From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 May 2012 12:45:18 +0800
Subject: [PATCH v2 08/12] ARM: imx6q: add usbphy clocks
In-Reply-To: <201205220632.13896.marex@denx.de>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-9-git-send-email-richard.zhao@freescale.com>
 <201205220632.13896.marex@denx.de>
Message-ID: <20120522044515.GK8140@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 06:32:13AM +0200, Marek Vasut wrote:
> Dear Richard Zhao,
> 
> Maybe reorder this so it's in before the PHY driver?
> 
It should not matter, as I suppose all those "usb: ..." patches will
go via usb tree, while all those "ARM: ..." will go via arm-soc tree.

-- 
Regards,
Shawn
