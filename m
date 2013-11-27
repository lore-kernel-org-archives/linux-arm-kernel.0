From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 27 Nov 2013 13:18:15 +0000
Subject: [PATCH v4 1/5] mfd: max14577: Add max14577 MFD driver core
In-Reply-To: <1385135469-27044-2-git-send-email-k.kozlowski@samsung.com>
References: <1385135469-27044-1-git-send-email-k.kozlowski@samsung.com>
 <1385135469-27044-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131127131815.GI3296@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Nov 2013, Krzysztof Kozlowski wrote:

> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch adds max14577 core/irq driver to support MUIC(Micro USB IC)
> device and charger device and support irq domain method to control
> internal interrupt of max14577 device. Also, this patch supports DT
> binding with max14577_i2c_parse_dt().
> 
> The MAXIM 14577 chip contains Micro-USB Interface Circuit and Li+ Battery
> Charger. It contains accessory and USB charger detection logic. It supports
> USB 2.0 Hi-Speed, UART and stereo audio signals over Micro-USB connector.
> 
> The battery charger is compliant with the USB Battery Charging Specification
> Revision 1.1. It has also SFOUT LDO output for powering USB devices.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/mfd/Kconfig                  |   13 ++
>  drivers/mfd/Makefile                 |    1 +
>  drivers/mfd/max14577.c               |  243 +++++++++++++++++++++++++
>  include/linux/mfd/max14577-private.h |  330 ++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max14577.h         |   69 +++++++
>  5 files changed, 656 insertions(+)
>  create mode 100644 drivers/mfd/max14577.c
>  create mode 100644 include/linux/mfd/max14577-private.h
>  create mode 100644 include/linux/mfd/max14577.h

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
