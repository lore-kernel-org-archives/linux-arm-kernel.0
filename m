From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 10 Jun 2016 18:12:46 +0900
Subject: [PATCH v2 7/7] iommu/rockchip: enable rockchip iommu on ARM64
 platform
In-Reply-To: <1465392392-2003-8-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-8-git-send-email-zhengsq@rock-chips.com>
Message-ID: <CAAFQd5CRWhSQKtTqfHHHBPGK2=C=BhB7x3KtykCJTqGhq5VfGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 8, 2016 at 10:26 PM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> From: Simon Xue <xxm@rock-chips.com>
>

It is usual a good practice to include at least a single sentence
here, even if the patch is trivial. In this case it could say

"This patch makes it possible to compile the rockchip-iommu driver on
ARM64 platform to be used with 64-bit SoCs equipped with this type of
IOMMU."

> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Assuming that the above is fixed:

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
