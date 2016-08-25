From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 25 Aug 2016 12:34:00 +0100
Subject: [STLinux Kernel] [PATCH 0/7] ARM: dts: STi: Make way for new
 Linaro 96Board: ST B2260
In-Reply-To: <20160815121740.29515-1-lee.jones@linaro.org>
References: <20160815121740.29515-1-lee.jones@linaro.org>
Message-ID: <20160825113400.GA3281@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice / Lee,

On Mon, 15 Aug 2016, Lee Jones wrote:

> This series paves the way for the new Linaro B2260 96Board, designed
> and built by ST-Microelectronics.
> 
> Patrice Chotard (7):
>   ARM: dts: STiH407: Move pio20 node to fix kernel warning
>   ARM: dts: STiH410: Add thermal node
>   ARM: dts: STiH407-pinctrl: Add i2c2_alt2_1 node
>   ARM: dts: STiH407: Move non-removable property to board file
>   ARM: dts: STiH407-pinctrl: Add pinctrl_rgmii1_mdio_1 node
>   ARM: dts: STiH407-family: Add ports-implemented property in sata nodes
>   ARM: dts: STi: Introduce B2260 board

For the series: -
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
