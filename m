From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jan 2016 00:42:14 +0800
Subject: [PATCH 10/10] vfio: allow the user to register reserved iova
 range for MSI mapping
In-Reply-To: <1453813968-2024-11-git-send-email-eric.auger@linaro.org>
Message-ID: <201601270054.qutwYmbG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[auto build test ERROR on v4.5-rc1]
[also build test ERROR on next-20160125]
[cannot apply to iommu/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64/20160126-211921
config: x86_64-randconfig-s3-01262306 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   ERROR: "alloc_iova" [drivers/vfio/vfio_iommu_type1.ko] undefined!
>> ERROR: "init_iova_domain" [drivers/vfio/vfio_iommu_type1.ko] undefined!
>> ERROR: "put_iova_domain" [drivers/vfio/vfio_iommu_type1.ko] undefined!
   ERROR: "free_iova" [drivers/vfio/vfio_iommu_type1.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23402 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/5b40d37f/attachment-0001.obj>
