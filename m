From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 4 Jul 2018 16:57:20 +0200
Subject: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
In-Reply-To: <20180704224511.29350-1-yixun.lan@amlogic.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
Message-ID: <78da7e13-e80b-d714-86d0-7c5f6fc0d9f5@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

On 05/07/2018 00:45, Yixun Lan wrote:
> This patch series try to add pinctrl driver support for
> the Meson-G12A SoC.

Thanks for submitting these patches.

Can you explicit this patchset with more details on the G12A SoC family ?
It's relationship with AXG and the differences in term of pinmuxing with the other SoC families ?

Why is there a GPIOE bank within the AO controller ?

Thanks,
Neil

> 
> Yixun Lan (3):
>   documentation: Add compatibles for Amlogic Meson G12A pin controllers
>   dt-bindings: pinctrl: meson-g12a: document pin name
>   pinctrl: meson-g12a: add pinctrl driver support
> 
>  .../bindings/pinctrl/meson,pinctrl.txt        |    2 +
>  drivers/pinctrl/meson/Kconfig                 |    6 +
>  drivers/pinctrl/meson/Makefile                |    1 +
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 1432 +++++++++++++++++
>  include/dt-bindings/gpio/meson-g12a-gpio.h    |  114 ++
>  5 files changed, 1555 insertions(+)
>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
> 
