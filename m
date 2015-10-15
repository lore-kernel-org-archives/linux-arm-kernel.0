From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 15 Oct 2015 13:51:12 +0200
Subject: [PATCH 0/4] Enable Ethernet on StiH407 family boards
In-Reply-To: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
References: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <561F9330.7030309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/01/2015 05:56 PM, Maxime Coquelin wrote:
> This series enables Ethernet support on STiH407 family reference design
> boards.
>
> These boards use the RTL8367 Switch as PHY.
> As it is previously configured by the bootloader, we declare it as a fixed
> link.
>
> Maxime Coquelin (4):
>    ARM: dts: Fix RGMII pinctrl timings
>    ARM: dts: Add Ethernet node to STiH407 family
>    ARM: dts: Enable Ethernet on STi's B2120 boards
>    ARM: dts: Enable Ethernet on STi's B2199 board
>
>   arch/arm/boot/dts/stih407-b2120.dts    |  1 +
>   arch/arm/boot/dts/stih407-family.dtsi  | 27 +++++++++++++++++++++++++++
>   arch/arm/boot/dts/stih407-pinctrl.dtsi |  4 ++--
>   arch/arm/boot/dts/stih410-b2120.dts    |  1 +
>   arch/arm/boot/dts/stih418-b2199.dts    |  8 ++++++++
>   arch/arm/boot/dts/stihxxx-b2120.dtsi   |  6 ++++++
>   6 files changed, 45 insertions(+), 2 deletions(-)
>
Series applied.

Maxime
