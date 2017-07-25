From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Jul 2017 17:07:52 +0800
Subject: [PATCH 0/5] ARM: dts: imx6: RDU2: Ethernet switch and PHYs
In-Reply-To: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
References: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
Message-ID: <20170725090751.GI20064@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 10:24:59PM +0200, Andrew Lunn wrote:
> This patchset extends the RDU2 to support its Ethernet switch, the
> PHYs within the switch, the switches EEPROM, and the Micrel
> PHY connected to the FEC.
> 
> Andrew Lunn (5):
>   ARM: dts: imx6: RDU2: Add Micrel PHY to FEC
>   ARM: dts: imx6: RDU2: Add DSA support for the Marvell 88E6352
>   ARM: dts: imx6: RDU2: Add Switch EEPROM
>   ARM: dts: imx6: RDU2: Add Switch interrupts
>   ARM: dts: imx6: RDU2: Add Micrel PHY interrupt

Applied all, thanks.
