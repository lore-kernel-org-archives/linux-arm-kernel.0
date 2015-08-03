From: jroedel@suse.de (Joerg Roedel)
Date: Mon, 3 Aug 2015 16:26:14 +0200
Subject: [PATCH v3 04/24] intel_iommu: fix leaked ioremap mapping
In-Reply-To: <20150730165401.33962.81348.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150730165155.33962.64121.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150730165401.33962.81348.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150803142537.GY27614@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 12:54:01PM -0400, Dan Williams wrote:
> iommu_load_old_irte() appears to leak the old_irte mapping after use.
> 
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/iommu/intel_irq_remapping.c |    2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
