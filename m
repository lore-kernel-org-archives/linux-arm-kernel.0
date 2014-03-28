From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Mar 2014 08:01:37 +0000
Subject: [PATCH v3 00/10] mfd: AXP20x: Add support for AXP202 and AXP209
In-Reply-To: <1395955764-18103-1-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
Message-ID: <20140328080137.GE17779@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> AXP209 and AXP202 are the PMUs (Power Management Unit) used by A10, A13
> and A20 SoCs and developed by X-Powers, a sister company of Allwinner.
> AXP20x comprises an adaptive USB-Compatible PWM charger, 2 BUCK DC-DC
> converters, 5 LDOs, multiple 12-bit ADCs of voltage, current and temperature
> as well as 4 configurable GPIOs. 

[...]

> Carlo Caione (10):
>   mfd: AXP20x: Add mfd driver for AXP20x PMIC
>   dt-bindings: add vendor-prefix for X-Powers
>   mfd: AXP20x: Add bindings documentation
>   input: misc: Add driver for AXP20x Power Enable Key
>   input: misc: Add ABI docs for AXP20x PEK
>   regulator: AXP20x: Add support for regulators subsystem
>   ARM: sunxi: dt: Add x-powers-axp209.dtsi file
>   ARM: sun7i/sun4i: dt: Add AXP209 support to various boards
>   ARM: sunxi: Add AXP20x support in defconfig
>   ARM: sunxi: Add AXP20x support multi_v7_defconfig

I'm only CC'ed on two of these patches. In order to gain a full
appreciation what what the set is trying to achieve, can you CC me on
the entire set please?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
