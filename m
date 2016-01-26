From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 26 Jan 2016 17:37:49 +0100
Subject: [PATCH 06/10] vfio: introduce
 vfio_group_alloc_map_/unmap_free_reserved_iova
In-Reply-To: <201601270035.rJBZW1lE%fengguang.wu@intel.com>
References: <201601270035.rJBZW1lE%fengguang.wu@intel.com>
Message-ID: <56A7A0DD.2080504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 01/26/2016 05:17 PM, kbuild test robot wrote:
> Hi Eric,
> 
> [auto build test ERROR on v4.5-rc1]
> [also build test ERROR on next-20160125]
> [cannot apply to iommu/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64/20160126-211921
> config: x86_64-randconfig-s3-01262306 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: "alloc_iova" [drivers/vfio/vfio_iommu_type1.ko] undefined!
>>> ERROR: "free_iova" [drivers/vfio/vfio_iommu_type1.ko] undefined!

I will protect the code with CONFIG_IOMMU_IOVA if the usage of those
functions is acknowledged.

Thanks

Eric
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
