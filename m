From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 5 Nov 2016 11:39:13 +0100
Subject: [PATCH net-next 2/2] net: phy: Add Meson GXL Internal PHY driver
In-Reply-To: <1478274683-1503-3-git-send-email-narmstrong@baylibre.com>
References: <1478274683-1503-1-git-send-email-narmstrong@baylibre.com>
 <1478274683-1503-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20161105103913.GB24961@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 04:51:23PM +0100, Neil Armstrong wrote:
> Add driver for the Internal RMII PHY found in the Amlogic Meson GXL SoCs.
> 
> This PHY seems to only implement some standard registers and need some
> workarounds to provide autoneg values from vendor registers.
> 
> Some magic values are currently used to configure the PHY, and this a
> temporary setup until clarification about these registers names and
> registers fields are provided by Amlogic.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
