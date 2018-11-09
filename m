From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Nov 2018 21:13:28 +0100
Subject: [PATCH net-next v3 2/2] net: phy: remove flag PHY_HAS_INTERRUPT
 from driver configs
In-Reply-To: <15f15b61-1dc2-e204-0a08-f2d8f73c227d@gmail.com>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <15f15b61-1dc2-e204-0a08-f2d8f73c227d@gmail.com>
Message-ID: <20181109201328.GW5259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 06:17:22PM +0100, Heiner Kallweit wrote:
> Now that flag PHY_HAS_INTERRUPT has been replaced with a check for
> callbacks config_intr and ack_interrupt, we can remove setting this
> flag from all driver configs.
> Last but not least remove flag PHY_HAS_INTERRUPT completely.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks for removing them all.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
