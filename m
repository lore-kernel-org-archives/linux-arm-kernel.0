From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Dec 2015 10:47:15 +0800
Subject: [PATCH 0/8] Add support for CL-SOM-iMX7 and SBC-iMX7
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <20151214024715.GD25756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 09:14:31AM +0200, Ilya Ledvich wrote:
> Ilya Ledvich (8):
>   ARM: dts: imx7d: cl-som-imx7: add basic module support
>   ARM: dts: imx7d: cl-som-imx7: add usb otg support
>   ARM: dts: imx7d: cl-som-imx7: add eMMC support
>   ARM: dts: imx7d: cl-som-imx7: add fec1 support
>   ARM: dts: imx7d: cl-som-imx7: add eeprom support
>   ARM: dts: imx7d: cl-som-imx7: add gpio extender support
>   ARM: dts: imx7d: cl-som-imx7: add fec2 support

For the initial board support submission, it doesn't really need such
splitting.  Please merge above patches into one.

Shawn

>   ARM: dts: imx7d: sbc-imx7: add basic board support
