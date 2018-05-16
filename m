From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 16 May 2018 10:50:24 +0800
Subject: [PATCH 0/3] irqchip: meson-gpio: add support for Meson-AXG SoCs
In-Reply-To: <20180408145700.23520-1-yixun.lan@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
Message-ID: <0c97c61b-c05b-21cf-c880-80cff04ed6f2@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc (or anyone else)

On 04/08/18 22:56, Yixun Lan wrote:
>   This series try to add GPIO interrupt controller support for Meson-AXG SoCs.
>   The first patch is a trivial typo fix, I can fold the first two patches
> together if necessary.
> 
> Yixun Lan (3):
>   dt-bindings: interrupt-controller: fix the double quotes
>   dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
>   irqchip/meson-gpio: add support for Meson-AXG SoCs
> 
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 11 ++++++-----
>  drivers/irqchip/irq-meson-gpio.c                              |  5 +++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 

please consider this merely a ping..
will you take this series, or is there anything holding this?

thanks

Yixun
