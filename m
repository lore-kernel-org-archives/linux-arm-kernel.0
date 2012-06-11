From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Jun 2012 15:13:03 +0800
Subject: [PATCH] MXS: Enable FLEXCAN for MXS/DT
In-Reply-To: <1339181830-22863-1-git-send-email-marex@denx.de>
References: <1339181830-22863-1-git-send-email-marex@denx.de>
Message-ID: <20120611071300.GF2552@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please use something like "ARM: mxs: Enable FLEXCAN for DT" for the
subject.

On Fri, Jun 08, 2012 at 08:57:10PM +0200, Marek Vasut wrote:
> +				flexcan0_pins_a: flexcan0 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x0161 0x0162>;

Are you sure the second cell is correct?  From what
Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt tells:

MX28_PAD_GPMI_RDY2__ENET0_TX_ER                 0x0162

> +					fsl,drive-strength = <2>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
> +				flexcan1_pins_a: flexcan1 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x0121 0x0122>;

Ditto

MX28_PAD_GPMI_CE2N__ENET0_RX_ER                 0x0122

> +					fsl,drive-strength = <2>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +

-- 
Regards,
Shawn
