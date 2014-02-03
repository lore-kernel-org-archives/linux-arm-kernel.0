From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Feb 2014 09:38:09 +0000
Subject: [PATCH 07/18] mfd: max14577: Rename and add MAX14577 symbols to
 prepare for max77836
In-Reply-To: <1390911522-28209-8-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140203093809.GH13529@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch prepares for adding support for max77836 device to existing
> max14577 driver:
> 1. Renames most of symbols and defines prefixed with MAX14577 to MAXIM.
> 2. Adds prefixes (MAXIM or MAX14577) to defines without any MAX* prefix.
> 
> This is only a rename-like patch, new code is not added.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max14577.c     |  105 ++++-----
>  drivers/mfd/max14577.c               |   51 ++---
>  drivers/power/max14577_charger.c     |   81 +++----
>  drivers/regulator/max14577.c         |   44 ++--
>  include/linux/mfd/max14577-private.h |  399 ++++++++++++++++------------------
>  include/linux/mfd/max14577.h         |    2 +-
>  6 files changed, 333 insertions(+), 349 deletions(-)

I think the name changes instil some clarity here.

I still need the other Acks before applying the patch though.

For now you can have my:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
