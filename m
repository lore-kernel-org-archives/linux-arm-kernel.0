From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 06 Feb 2014 10:55:02 +0900
Subject: [PATCH 08/18] mfd: max14577: Rename state container to maxim_core
In-Reply-To: <1390911522-28209-9-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-9-git-send-email-k.kozlowski@samsung.com>
Message-ID: <52F2EB76.5010908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 09:18 PM, Krzysztof Kozlowski wrote:
> This patch continues the preparation for adding support for max77836
> device to existing max14577 driver.
> 
> The patch renames the struct "max14577" state container to "maxim_core".
> This is only a rename-like patch, new code is not added.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max14577.c     |   22 +++++------
>  drivers/mfd/max14577.c               |   68 +++++++++++++++++-----------------
>  drivers/power/max14577_charger.c     |   16 ++++----
>  drivers/regulator/max14577.c         |    6 +--
>  include/linux/mfd/max14577-private.h |    5 ++-
>  5 files changed, 60 insertions(+), 57 deletions(-)
> 

For extcon:
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

For mfd/regulator/charger/extcon of max14577
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
