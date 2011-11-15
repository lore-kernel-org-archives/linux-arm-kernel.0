From: Joerg.Roedel@amd.com (Joerg Roedel)
Date: Tue, 15 Nov 2011 16:49:54 +0100
Subject: [PATCH v4-rebased 0/7] iommu: split mapping to page sizes as
 supported by the hardware
In-Reply-To: <1320917551-11328-1-git-send-email-ohad@wizery.com>
References: <1320917551-11328-1-git-send-email-ohad@wizery.com>
Message-ID: <20111115154954.GD5627@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 11:32:24AM +0200, Ohad Ben-Cohen wrote:
> Ohad Ben-Cohen (7):
>   iommu/core: stop converting bytes to page order back and forth
>   iommu/core: split mapping to page sizes as supported by the hardware
>   iommu/omap: announce supported page sizes
>   iommu/msm: announce supported page sizes
>   iommu/amd: announce supported page sizes
>   iommu/intel: announce supported page sizes
>   iommu/core: remove the temporary pgsize settings
> 
>  drivers/iommu/amd_iommu.c   |   32 +++++++++---
>  drivers/iommu/intel-iommu.c |   30 ++++++++---
>  drivers/iommu/iommu.c       |  119 ++++++++++++++++++++++++++++++++++++++----
>  drivers/iommu/msm_iommu.c   |   25 ++++-----
>  drivers/iommu/omap-iommu.c  |   18 +++---
>  drivers/iommu/omap-iovmm.c  |   17 ++----
>  include/linux/iommu.h       |   26 +++++++--
>  virt/kvm/iommu.c            |    8 ++--
>  8 files changed, 205 insertions(+), 70 deletions(-)

Applied, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
