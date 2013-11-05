From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Nov 2013 20:22:52 +0800
Subject: [PATCHv10][ 4/7] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <1383647918-27315-4-git-send-email-denis@eukrea.com>
References: <1383647918-27315-1-git-send-email-denis@eukrea.com>
 <1383647918-27315-4-git-send-email-denis@eukrea.com>
Message-ID: <20131105122250.GO19770@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 11:38:35AM +0100, Denis Carikli wrote:
>  .../bindings/pinctrl/fsl,imx25-pinctrl.txt         |   33 ++

>  arch/arm/boot/dts/imx25-pinfunc.h                  |  513 ++++++++++++++++++++
>  arch/arm/boot/dts/imx25-pingrp.h                   |   79 +++
>  arch/arm/boot/dts/imx25.dtsi                       |    1 +

Unless Linus gives his ACK on the patch to have it go via IMX tree, we
need to split above 3 files into another patch that we can apply on IMX
tree, because other patches e.g. the last one in the series depends on
them.

BTW, it seems that you missed the comments that Sascha and Markus put on
the v9 of the patch.

Shawn

>  drivers/pinctrl/Kconfig                            |    9 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-imx25.c                    |  351 ++++++++++++++
>  7 files changed, 987 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
>  create mode 100644 arch/arm/boot/dts/imx25-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/imx25-pingrp.h
>  create mode 100644 drivers/pinctrl/pinctrl-imx25.c
