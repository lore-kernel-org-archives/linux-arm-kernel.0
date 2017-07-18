From: cphealy@gmail.com (Chris Healy)
Date: Mon, 17 Jul 2017 17:42:16 -0700
Subject: [PATCH 0/5] ARM: dts: imx6: RDU2: Ethernet switch and PHYs
In-Reply-To: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
References: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAFXsbZrtDqprDkcazbkJ5reJ80UYzJAzx3sCnBp7UnoZEC6aNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I tested the full series successfully on the RDU2 platform.

Tested-by: Chris Healy <cphealy@gmail.com>


On Mon, Jul 17, 2017 at 1:24 PM, Andrew Lunn <andrew@lunn.ch> wrote:
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
>
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 112 +++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 3 deletions(-)
>
> --
> 2.13.2
>
