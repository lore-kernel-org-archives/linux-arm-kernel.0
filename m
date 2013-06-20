From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 20 Jun 2013 12:00:52 +0200
Subject: [PATCH 08/11] iommu/msm: Move mach includes to iommu directory
In-Reply-To: <1371600281-6118-9-git-send-email-sboyd@codeaurora.org>
References: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
 <1371600281-6118-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130620100052.GL2575@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 05:04:38PM -0700, Stephen Boyd wrote:
> Two header files exist in mach-msm's include/mach directory that
> are only used by the MSM iommu driver. Move these files to the
> iommu driver directory and prefix them with "msm_". This allows
> us to compile the MSM iommu driver on multi-platform kernels.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Joerg, please ack so this can go through the MSM tree.

Sure thing.

Acked-by: Joerg Roedel <joro@8bytes.org>
