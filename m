From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 15 Jun 2016 15:31:04 +0200
Subject: [PATCH v2 3/3] iommu: convert DT component matching to
 component_match_add_release()
In-Reply-To: <E1b8pyc-0005OV-7X@rmk-PC.armlinux.org.uk>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
 <E1b8pyc-0005OV-7X@rmk-PC.armlinux.org.uk>
Message-ID: <20160615133104.GL26566@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 03:21:30PM +0100, Russell King wrote:
> Convert DT component matching to use component_match_add_release().
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/iommu/mtk_iommu.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied, thanks.
