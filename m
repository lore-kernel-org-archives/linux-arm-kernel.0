From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 10 Jun 2016 14:30:14 +0900
Subject: [PATCH v2 1/7] iommu/rockchip: fix devm_{request,
 free}_irq parameter
In-Reply-To: <1465392392-2003-2-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-2-git-send-email-zhengsq@rock-chips.com>
Message-ID: <CAAFQd5BOZBqieA3xCi00jRCrYpZSAZmncAK2Qg69AuQGT5FQGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 8, 2016 at 10:26 PM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> From: Simon Xue <xxm@rock-chips.com>
>
> Even though the iommu shares irq with its master, using the *dev of iommu
> instead of master's *dev for devm_{request,free}_irq makes things clear.
>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
