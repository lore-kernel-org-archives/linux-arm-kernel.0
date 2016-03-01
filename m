From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 2 Mar 2016 02:19:49 +0800
Subject: [PATCH] iommu/mtk: fix handling of of_count_phandle_with_args
 result
In-Reply-To: <20160301113447.GO22747@8bytes.org>
References: <1456824983-13550-1-git-send-email-a.hajda@samsung.com>
 <20160301113447.GO22747@8bytes.org>
Message-ID: <1456856389.26149.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-03-01 at 12:34 +0100, Joerg Roedel wrote:
> On Tue, Mar 01, 2016 at 10:36:23AM +0100, Andrzej Hajda wrote:
> > The function can return negative value so it should be assigned to signed
> > variable. The patch changes also type of related i variable to make code
> > more compact and coherent.
> > 
> > The problem has been detected using patch
> > scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci.
> > 
> > Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Applied, thanks.

Thanks.

nit: It would be better to use iommu/mediatek.

> 
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
