From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Feb 2014 09:45:18 +0000
Subject: [PATCH 09/18] mfd: max14577: Add "muic" suffix to regmap and
 irq_chip
In-Reply-To: <1390911522-28209-10-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-10-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140203094518.GJ13529@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch continues the preparation for adding support for max77836
> device to existing max14577 driver.
> 
> Add "muic" suffix to regmap and irq_data fields in maxim_core state
> container to prepare for max77836 support.
> This is only a rename-like patch, new code is not added.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max14577.c     |   17 +++++++++--------
>  drivers/mfd/max14577.c               |   22 +++++++++++-----------
>  drivers/power/max14577_charger.c     |    8 ++++----
>  drivers/regulator/max14577.c         |    2 +-
>  include/linux/mfd/max14577-private.h |    4 ++--
>  5 files changed, 27 insertions(+), 26 deletions(-)

Happy to apply this with maintainer Acks.
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
