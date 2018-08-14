From: lkp@intel.com (kbuild test robot)
Date: Tue, 14 Aug 2018 19:45:18 +0800
Subject: [PATCH 2/2] PCI: meson: add the Amlogic Meson PCIe controller
 driver
In-Reply-To: <1534227522-186798-3-git-send-email-hanjie.lin@amlogic.com>
References: <1534227522-186798-3-git-send-email-hanjie.lin@amlogic.com>
Message-ID: <201808141947.vOJGIxXg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yue,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.18 next-20180813]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hanjie-Lin/dt-bindings-PCI-meson-add-DT-bindings-for-Amlogic-Meson-PCIe-controller/20180814-180019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/controller/dwc/pci-meson.c:121:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
