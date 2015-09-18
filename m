From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Sep 2015 11:02:33 +0200
Subject: [PATCH 0/5] ARM: sunxi: Introduce CHIP support
In-Reply-To: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <2353279.QTDzFUHVnF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 September 2015 10:48:45 Maxime Ripard wrote:
> 
> Here is a serie introducing the support for the Allwinner R8 and the
> Nextthing's CHIP.
> 
> Support is almost complete for the CHIP itself, the only missing part
> for now is the WiFi chip that needs to be powered through two combined
> regulators (AXP209's LDO3 and LDO4). The audio codec is also missing
> since it's not already enabled in the DT.
> 
> Both these features will be addressed eventually.
> 
> Let me know what you think,

Very nice!

When you get to the WiFi support, please loop in Ulf and me to the Cc list.
IIRC there were some open questions about how we should handle SDIO wifi
controllers with special requirements like this, both in general and
in particular with this driver.

	Arnd
