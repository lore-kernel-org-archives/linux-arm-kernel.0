From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Mar 2015 12:00:03 +0100
Subject: [PATCH 10/16] iommu/tegra-gart: Make use of domain_alloc and
 domain_free
In-Reply-To: <1427373799-18662-11-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
 <1427373799-18662-11-git-send-email-joro@8bytes.org>
Message-ID: <20150327110002.GB5440@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 01:43:13PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Implement domain_alloc and domain_free iommu-ops as a
> replacement for domain_init/domain_destroy.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/tegra-gart.c | 67 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 46 insertions(+), 21 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150327/62a87ba0/attachment.sig>
