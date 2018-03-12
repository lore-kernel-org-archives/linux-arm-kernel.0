From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 12 Mar 2018 21:36:51 +0800
Subject: [xlnx:master 1273/1520] warning: (DRM_RADEON && ..) selects
 BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && ..)
Message-ID: <201803122150.iq0a6IFz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   ef99b59d41d9546fe561e61fb7a489c83a544a2f
commit: 4d08c576e74d1f07fbfd2a0be564fc3b59fe2e99 [1273/1520] drm: xlnx: dsi: Adding dsi driver to new framework
config: x86_64-randconfig-x001-201810 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 4d08c576e74d1f07fbfd2a0be564fc3b59fe2e99
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

warning: (DRM_RADEON && DRM_AMDGPU && DRM_NOUVEAU && DRM_I915 && DRM_GMA500 && DRM_SHMOBILE && DRM_TILCDC && DRM_FSL_DCU && DRM_TINYDRM && DRM_XLNX_DSI && DRM_PARADE_PS8622 && FB_BACKLIGHT && FB_ARMCLCD && FB_MX3 && USB_APPLEDISPLAY && FB_OLPC_DCON && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20715 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180312/25a5588f/attachment-0001.gz>
