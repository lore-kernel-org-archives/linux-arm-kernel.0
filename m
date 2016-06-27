From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 27 Jun 2016 14:57:51 +0200
Subject: iommu/rockchip: Fix bugs and enable on ARM64
In-Reply-To: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <20160627125751.GN11432@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 10:13:25AM +0800, Shunqian Zheng wrote:
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 100 +++++++------
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   3 +
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 221 ++++++++++++++++++++++++++--
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   9 ++
>  drivers/iommu/Kconfig                       |   2 +-
>  drivers/iommu/rockchip-iommu.c              | 181 +++++++++++++++++------
>  6 files changed, 413 insertions(+), 103 deletions(-)

Applied the IOMMU patches, thanks.


	Joerg
