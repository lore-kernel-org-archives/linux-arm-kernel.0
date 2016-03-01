From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 1 Mar 2016 12:34:47 +0100
Subject: [PATCH] iommu/mtk: fix handling of of_count_phandle_with_args
 result
In-Reply-To: <1456824983-13550-1-git-send-email-a.hajda@samsung.com>
References: <1456824983-13550-1-git-send-email-a.hajda@samsung.com>
Message-ID: <20160301113447.GO22747@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2016 at 10:36:23AM +0100, Andrzej Hajda wrote:
> The function can return negative value so it should be assigned to signed
> variable. The patch changes also type of related i variable to make code
> more compact and coherent.
> 
> The problem has been detected using patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.
