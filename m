From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Jan 2017 17:58:28 +0100
Subject: [PATCH 1/5] iommu: Generalize MSM_IOMMU config to ARCH_QCOM
In-Reply-To: <20170118232726.22876-2-sboyd@codeaurora.org>
References: <20170118232726.22876-1-sboyd@codeaurora.org>
 <20170118232726.22876-2-sboyd@codeaurora.org>
Message-ID: <20170126165827.GA27598@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 03:27:22PM -0800, Stephen Boyd wrote:
> We want to get rid of the ARCH_MSM* configs in the future, but
> this still depends on them. Generalize to the ARCH_QCOM config,
> which isn't going away.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Joerg Roedel <jroedel@suse.de>
