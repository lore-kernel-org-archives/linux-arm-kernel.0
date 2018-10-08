From: lkp@intel.com (kbuild test robot)
Date: Tue, 9 Oct 2018 02:17:59 +0800
Subject: [PATCH v4 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
In-Reply-To: <1538999834-156423-3-git-send-email-hanjie.lin@amlogic.com>
References: <1538999834-156423-3-git-send-email-hanjie.lin@amlogic.com>
Message-ID: <201810090208.N3NrdpgK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yue,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.19-rc7 next-20181008]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hanjie-Lin/add-the-Amlogic-Meson-PCIe-controller-driver/20181009-001429
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/controller/dwc/pci-meson.c:190:1-3: WARNING: PTR_ERR_OR_ZERO can be used
   drivers/pci/controller/dwc/pci-meson.c:267:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
