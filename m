From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 13 May 2015 11:27:11 +0200
Subject: [STLinux Kernel] [PATCH 00/13] ARM: STi: Clear-up dangling patches
In-Reply-To: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
References: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
Message-ID: <555318EF.7030603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 05/12/2015 02:51 PM, Lee Jones wrote:
> These patches have all been on the list for some time now.
> I've taken the liberty of collecting them all up to send
> as a single batch.
>
> Lee Jones (13):
>    ARM: STi: STiH407: Add DT nodes for for PWM
>    ARM: STi: STiH416: Add Pinctrl settings for PWM
>    ARM: STi: STiH416: Add DT nodes for PWM
>    ARM: STi: STiH416-b2020e: Enable PWM on the B2020 Rev-E
>    ARM: multi_v7_defconfig: Enable ST's PWM driver
>    ARM: STi: STiH407: Add Restart support for Cannes
>    ARM: STi: STiH416: Add Restart support for Orly2
>    ARM: multi_v7_defconfig: Enable ST's Power Reset driver
>    ARM: STi: STiH416: Enable Cortex-A9 PMU support
>    ARM: STi: STiH416: Enable PMU IRQs
>    ARM: STi: STiH407: Enable Cortex-A9 PMU support
>    ARM: STi: STiH407: Enable PMU IRQs
>    ARM: STi: Ensure requested STi's SysCfg Controlled IRQs are enabled at
>      boot
>
>   arch/arm/boot/dts/stih407-family.dtsi  | 22 ++++++++++++
>   arch/arm/boot/dts/stih407.dtsi         | 28 +++++++++++++++
>   arch/arm/boot/dts/stih416-b2020e.dts   | 10 ++++++
>   arch/arm/boot/dts/stih416-pinctrl.dtsi | 50 ++++++++++++++++++++++++++
>   arch/arm/boot/dts/stih416.dtsi         | 66 +++++++++++++++++++++++++++++++++-
>   arch/arm/configs/multi_v7_defconfig    |  2 ++
>   arch/arm/mach-sti/Kconfig              |  1 +
>   7 files changed, 178 insertions(+), 1 deletion(-)
>

Series applied.

Note that I fixed patches 6 & 7 titles to use commercial product names.

Thanks!
Maxime
