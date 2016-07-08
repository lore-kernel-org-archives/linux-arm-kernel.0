From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 8 Jul 2016 09:01:58 +0800
Subject: iommu/rockchip: Fix bugs and enable on ARM64
In-Reply-To: <20160627125751.GN11432@8bytes.org>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
 <20160627125751.GN11432@8bytes.org>
Message-ID: <577EFB86.1060502@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?06?27? 20:57, Joerg Roedel wrote:
> On Fri, Jun 24, 2016 at 10:13:25AM +0800, Shunqian Zheng wrote:
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 100 +++++++------
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   3 +
>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 221 ++++++++++++++++++++++++++--
>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   9 ++
>>   drivers/iommu/Kconfig                       |   2 +-
>>   drivers/iommu/rockchip-iommu.c              | 181 +++++++++++++++++------
>>   6 files changed, 413 insertions(+), 103 deletions(-)
> Applied the IOMMU patches, thanks.
>
>
> 	Joerg
>
>
>
>

Hi Joerg

The drm rockchip patches are dependent on iommu/rockchip patches, can 
you also apply these patches together? So that can avoid compile problem.

Thanks.

-- 
?ark Yao
