From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 Dec 2017 12:44:25 +0100
Subject: [PATCH 1/2] net: dsa: allow XAUI phy interface mode
In-Reply-To: <E1eOgsk-0001AU-5z@rmk-PC.armlinux.org.uk>
References: <E1eOgsk-0001AU-5z@rmk-PC.armlinux.org.uk>
Message-ID: <20171212114425.GO28672@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 09:29:46AM +0000, Russell King wrote:
> XGMII is a 32-bit bus plus two clock signals per direction.  XAUI is
> four serial lanes per direction.  The 88e6190 supports XAUI but not
> XGMII as it doesn't have enough pins.  The same is true of 88e6176.
> 
> Match on PHY_INTERFACE_MODE_XAUI for the XAUI port type, but keep
> accepting XGMII for backwards compatibility.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
