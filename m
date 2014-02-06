From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 06 Feb 2014 10:53:09 +0900
Subject: [PATCH 07/18] mfd: max14577: Rename and add MAX14577 symbols to
 prepare for max77836
In-Reply-To: <1390911522-28209-8-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <52F2EB05.2070009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 09:18 PM, Krzysztof Kozlowski wrote:
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
> 

For extcon:
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
