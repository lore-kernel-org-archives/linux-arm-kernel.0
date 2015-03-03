From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 3 Mar 2015 12:03:20 +0100
Subject: [PATCH v2 8/8] ARM: STi: DT: STiH407: Add dt nodes for sdhci
 and emmc.
In-Reply-To: <1424956227-18258-9-git-send-email-peter.griffin@linaro.org>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-9-git-send-email-peter.griffin@linaro.org>
Message-ID: <54F594F8.50306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/26/2015 02:10 PM, Peter Griffin wrote:
> The nodes have been split to allow as much commonality as possible.
> The stih407 has a silicon bug with eMMC UHS modes (with top regs)
> and as such doesn't have any of the uhs dt properties.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 30 ++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stih410-b2120.dts   | 10 ++++++++++
>   arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
>   3 files changed, 48 insertions(+)
>
>
Maybe you could also add SD/eMMC support to the b2199 too?
I can test if you don't have the hardware yet.

Kind regards,
Maxime
