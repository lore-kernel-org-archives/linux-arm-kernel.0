From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Jul 2017 12:26:58 -0300
Subject: [PATCH 0/5] ARM: dts: imx6: RDU2: Ethernet switch and PHYs
In-Reply-To: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
References: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAOMZO5DK1Lw-uWVa4Azi22JsisRv4+6nOO-pZcYR-jvX7FQdSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 5:24 PM, Andrew Lunn <andrew@lunn.ch> wrote:
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

Series looks good:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
