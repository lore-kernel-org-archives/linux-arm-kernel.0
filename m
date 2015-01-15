From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Jan 2015 16:16:25 +0100
Subject: [PATCH v2 0/8] ARM: at91: dts: sama5d3: add dt support for atmel
 isi and ov2640 sensor
In-Reply-To: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
References: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
Message-ID: <54B7D9C9.5090001@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/01/2015 10:02, Josh Wu a ?crit :
> This patch series add ISI and ov2640 support on dts files.
> 
> As the ov2640 driver dt is still in review. The patch is in: https://patchwork.linuxtv.org/patch/27554/
> So I want to send this dt patch early for a review.
> 
> v1 -> v2:
>   1. add one more patch to change the pin name of ISI_MCK
>   2. rewrite the commit [4/8] ARM: at91: dts: sama5d3: change name of pinctrl_isi_{power,reset}.
>   3. move the common chip parts of ISI node to sama5d3.dtsi.
> 
> Bo Shen (3):
>   ARM: at91: dts: sama5d3: split isi pinctrl
>   ARM: at91: dts: sama5d3: add missing pins of isi
>   ARM: at91: dts: sama5d3: move the isi mck pin to mb
> 
> Josh Wu (5):
>   ARM: at91: dts: sama5d3: add isi clock
>   ARM: at91: dts: sama5d3: change name of pinctrl_isi_{power,reset}
>   ARM: at91: dts: sama5d3: change name of pinctrl of ISI_MCK
>   ARM: at91: dts: sama5d3: add ov2640 camera sensor support
>   ARM: at91: sama5: enable atmel-isi and ov2640 in defconfig

The whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

stacked on top of at91-3.20-dt.
The defconfig update on his side on at91-3.20-defconfig

Bye,

>  arch/arm/boot/dts/sama5d3.dtsi    | 24 ++++++++++++++++++-----
>  arch/arm/boot/dts/sama5d3xmb.dtsi | 40 +++++++++++++++++++++++++++++++++++----
>  arch/arm/configs/sama5_defconfig  |  6 ++++++
>  3 files changed, 61 insertions(+), 9 deletions(-)
> 


-- 
Nicolas Ferre
