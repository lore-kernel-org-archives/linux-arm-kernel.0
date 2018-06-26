From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 26 Jun 2018 15:01:18 +0200
Subject: [PATCH 0/3] Add STM32 SPI support on stm32mp157c
In-Reply-To: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
References: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <3cad9448-3e19-b686-8f90-d9c2c9928450@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 05/17/2018 04:21 PM, Amelie Delaunay wrote:
> This patch adds STM32 SPI support on stm32mp157c SoC.
> SPI1, available on GPIO expansion connector, is kept disabled, so these
> pins can be used as GPIOs by default.
> 
> Amelie Delaunay (3):
>    ARM: dts: stm32: add STM32 SPI support on stm32mp157c
>    ARM: dts: stm32: add SPI1 support on stm32mp157c-ev1
>    ARM: multi_v7_defconfig: enable STM32 SPI
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 16 +++++-
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     |  6 +++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 84 +++++++++++++++++++++++++++++++
>   arch/arm/configs/multi_v7_defconfig       |  1 +
>   4 files changed, 106 insertions(+), 1 deletion(-)
> 

DT patches applied on stm32-next.

Thanks
Alex
