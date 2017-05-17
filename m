From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 17 May 2017 14:31:23 +0200
Subject: [PATCH] iommu/rockchip: Enable Rockchip IOMMU on ARM64
In-Reply-To: <20170503151940.3987-1-mbrugger@suse.com>
References: <20170503151940.3987-1-mbrugger@suse.com>
Message-ID: <20170517123123.GA11068@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 05:19:40PM +0200, Matthias Brugger wrote:
> From: Simon Xue <xxm@rock-chips.com>
> 
> This patch makes it possible to compile the rockchip-iommu driver on
> ARM64, so that it can be used with 64-bit SoCs equipped with this type
> of IOMMU.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
