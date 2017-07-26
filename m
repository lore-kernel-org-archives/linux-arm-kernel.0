From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 26 Jul 2017 13:01:54 +0200
Subject: [PATCH] iommu: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-29-robh@kernel.org>
References: <20170718214339.7774-29-robh@kernel.org>
Message-ID: <20170726110154.GM15833@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:43:09PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: iommu at lists.linux-foundation.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> ---
>  drivers/iommu/fsl_pamu.c        | 20 ++++++++------------
>  drivers/iommu/fsl_pamu_domain.c | 10 ++++------
>  drivers/iommu/of_iommu.c        |  3 +--
>  drivers/iommu/rockchip-iommu.c  | 10 +++++-----
>  4 files changed, 18 insertions(+), 25 deletions(-)

Applied, thanks.
