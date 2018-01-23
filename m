From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 23 Jan 2018 18:39:32 +0800
Subject: [PATCH 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180117183244.28303-3-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-3-l.stach@pengutronix.de>
Message-ID: <20180123103931.GE27764@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 07:32:43PM +0100, Lucas Stach wrote:

> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +		};

Bad indentation.

Shawn

> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +};
> -- 
> 2.11.0
> 
