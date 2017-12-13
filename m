From: davem@davemloft.net (David Miller)
Date: Wed, 13 Dec 2017 14:59:34 -0500 (EST)
Subject: [PATCH 1/2] net: dsa: allow XAUI phy interface mode
In-Reply-To: <E1eOgsk-0001AU-5z@rmk-PC.armlinux.org.uk>
References: <E1eOgsk-0001AU-5z@rmk-PC.armlinux.org.uk>
Message-ID: <20171213.145934.2221372837492956535.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Tue, 12 Dec 2017 09:29:46 +0000

> XGMII is a 32-bit bus plus two clock signals per direction.  XAUI is
> four serial lanes per direction.  The 88e6190 supports XAUI but not
> XGMII as it doesn't have enough pins.  The same is true of 88e6176.
> 
> Match on PHY_INTERFACE_MODE_XAUI for the XAUI port type, but keep
> accepting XGMII for backwards compatibility.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied.
