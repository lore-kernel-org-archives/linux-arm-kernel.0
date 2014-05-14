From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 14 May 2014 13:46:14 +0200
Subject: [PATCH 0/9] ARM: STi: Add Clock driver support STiH415 & STiH416
In-Reply-To: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <53735786.5010202@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

for the series:

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime

On 05/05/2014 05:53 PM, Gabriel FERNANDEZ wrote:
> The goal of this series is to add DT definition for STiH415
> and STiH416 SoCs on B2000 and B2020 boards.
>
> Gabriel Fernandez (9):
>    ARM: STi: DT: STiH416: 416 DT Entry for clockgen A0/1/10/11/12
>    ARM: STi: DT: STiH416: Remove unused CLK_S_ICN_REG_0 fixed clock
>    ARM: STi: DT: STiH416: Remove unused CLK_S_GMAC0_PHY & CLK_S_ETH1_PHY
>      fixed clocks
>    ARM: STi: DT: STiH416: 416 DT Entry for clockgen B/C/D/E/F
>    ARM: STi: DT: STiH416: 416 DT Entry for clockgen A9/DDR/GPU
>    ARM: STi: DT: STiH415: 415 DT Entry for clockgen A0/1/10/11/12
>    ARM: STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock
>    ARM: STi: DT: STiH415: Remove unused CLK_S_GMAC0_PHY & CLK_S_ETH1_PHY
>      fixed clocks
>    ARM: STi: DT: STiH415: 415 DT Entry for clockgen A9
>
>   arch/arm/boot/dts/stih415-clks.h     |  15 +
>   arch/arm/boot/dts/stih415-clock.dtsi | 517 ++++++++++++++++++++++++-
>   arch/arm/boot/dts/stih415.dtsi       |  10 +-
>   arch/arm/boot/dts/stih416-clks.h     |  15 +
>   arch/arm/boot/dts/stih416-clock.dtsi | 732 ++++++++++++++++++++++++++++++++++-
>   arch/arm/boot/dts/stih416.dtsi       |  10 +-
>   6 files changed, 1256 insertions(+), 43 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stih415-clks.h
>   create mode 100644 arch/arm/boot/dts/stih416-clks.h
>
