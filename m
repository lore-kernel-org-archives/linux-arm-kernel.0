From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Feb 2014 10:23:25 +0000
Subject: [PATCH 14/18] extcon: max14577: Add support for max77836
In-Reply-To: <1390911522-28209-15-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-15-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140203102325.GM13529@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jan 2014, Krzysztof Kozlowski wrote:

> Add support for MAX77836 chipset to the max14577 extcon driver. The
> MAX77836 MUIC has additional interrupts (VIDRM, ADC1K) so IRQ handling
> is split up into two functions: max14577_parse_irq() and
> max77836_parse_irq().
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max14577.c     |  107 ++++++++++++++++++++++++++++------
>  drivers/mfd/max14577.c               |    1 +
>  include/linux/mfd/max14577-private.h |    3 +
>  3 files changed, 93 insertions(+), 18 deletions(-)

For the MFD changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
