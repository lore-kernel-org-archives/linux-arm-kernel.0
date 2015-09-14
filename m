From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 14 Sep 2015 14:32:42 +0200
Subject: [PATCH 00/11] ARM: STi: STiH407: Pinctrl updates
In-Reply-To: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <55F6BE6A.5030506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter

As already pointed by Lee, my signed-off needs to be removed from 
several patches
The overall series seems ok.

You can add my Acked-by

Thanks

On 09/11/2015 07:06 PM, Peter Griffin wrote:
> Hi Maxime / Patrice / Srini,
>
> This series makes a series of updates to the stih407 pinctrl groups
> and makes the upstream kernel more closely aligned in terms of pin
> configuration to the vendor kernel.
>
> A number of new periphs are added such as spi fsm, nand, cec0, and
> for others such as SPI the various alternate function pin muxings have
> been added. Finally for SPI the controller nodes have been updated
> to have the default pin assignment in the controller node.
>
> kind regards,
>
> Peter.
>
> Peter Griffin (11):
>    ARM: STi: DT: STiH407: Add a cec0 pin definition
>    ARM: STi: DT: STiH407: Add i2c3 alternate pin configs
>    ARM: DT: STiH407: Add SPI 3 wire and 4 wire pinctrl configs
>    ARM: DT: STiH407: Add serial3 pinctrl configuration
>    ARM: DT: STiH407: Add SPI FSM (NOR Flash) Controller pin config
>    ARM: DT: STiH407: Add NAND flash controller pin configuration
>    ARM: DT: STiH407: Add systrace pin configuration
>    ARM: DT: STiH407: Add SD pinctrl config for mmc0 controller
>    ARM: DT: STiH407: Add pinconfig for IRB UHF and IRB TX
>    ARM: DT: STiH407: Add RMII pinctrl support
>    ARM: STi: STiH407: Add spi default pinctrl groups.
>
>   arch/arm/boot/dts/stih407-family.dtsi  |  14 ++
>   arch/arm/boot/dts/stih407-pinctrl.dtsi | 378 ++++++++++++++++++++++++++++++++-
>   2 files changed, 387 insertions(+), 5 deletions(-)
>
