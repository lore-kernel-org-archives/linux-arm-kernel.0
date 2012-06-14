From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 14 Jun 2012 00:15:25 +0000
Subject: [Patch v5 09/13] ARM: imx6q: add usbphy clocks
In-Reply-To: <20120613215406.GF30400@pengutronix.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-10-git-send-email-richard.zhao@freescale.com>,
 <20120613215406.GF30400@pengutronix.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BE0ADB@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Could you recheck with your hardware guys which input clocks
> this device really has. On earlier i.MX there are up to three
> clocks this module needs. Sooner or later we want to use this driver on
> the other i.MX aswell, and then we'll need support for the other clocks
> here, no matter if they are software controllable on i.MX6 or not.

Only two clocks are needed for i.mx6, one is AHB clock usb gate which
is used to visit registers, and other is PHY clock which is used to data transfer.

The i.mx23, i.mx28 and i.mx6q use FSL Internal PHY, it doesn't need serial clock. 
 
