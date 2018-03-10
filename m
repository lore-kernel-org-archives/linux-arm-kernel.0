From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 11 Mar 2018 00:39:09 +0800
Subject: [xlnx:master 1273/1515] warning: (DRM_RADEON && ..) selects
 BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && ..)
Message-ID: <201803110008.0D5c6ByP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   f445aa62727567784c6e32780d9b13f1011ddc1c
commit: 4d08c576e74d1f07fbfd2a0be564fc3b59fe2e99 [1273/1515] drm: xlnx: dsi: Adding dsi driver to new framework
config: i386-randconfig-x018-201809 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 4d08c576e74d1f07fbfd2a0be564fc3b59fe2e99
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

warning: (DRM_RADEON && DRM_AMDGPU && DRM_NOUVEAU && DRM_I915 && DRM_GMA500 && DRM_SHMOBILE && DRM_TILCDC && DRM_FSL_DCU && DRM_TINYDRM && DRM_XLNX_DSI && DRM_PARADE_PS8622 && FB_BACKLIGHT && FB_ARMCLCD && FB_MX3 && USB_APPLEDISPLAY && FB_OLPC_DCON && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25834 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180311/91640e4b/attachment-0001.gz>
