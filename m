From: lkp@intel.com (kbuild test robot)
Date: Thu, 5 Oct 2017 16:00:43 +0800
Subject: [PATCHv2 2/2] phy: exynos5-usbdrd: Calibrate LOS levels for
 exynos5420/5800
In-Reply-To: <1507035578-24945-3-git-send-email-andrzej.p@samsung.com>
Message-ID: <201710051544.yeZytIjV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

[auto build test ERROR on phy/next]
[also build test ERROR on v4.14-rc3 next-20170929]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrzej-Pietrasiewicz/drivers-phy-add-calibrate-method/20171005-144320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: x86_64-randconfig-b0-10051313 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "phy_calibrate" [drivers/usb/dwc3/dwc3.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27608 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171005/5d554f92/attachment-0001.gz>
