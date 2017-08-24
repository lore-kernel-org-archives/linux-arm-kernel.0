From: lkp@intel.com (kbuild test robot)
Date: Fri, 25 Aug 2017 00:24:00 +0800
Subject: [PATCH 1/3] pci: designware: add driver for DWC controller in
 ECAM shift mode
In-Reply-To: <20170821192907.8695-2-ard.biesheuvel@linaro.org>
Message-ID: <201708250050.JQLhJI9c%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.13-rc6 next-20170824]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/pci-add-support-for-firmware-initialized-designware-RCs/20170824-232638
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: m68k-allmodconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

warning: (PCIE_DW_HOST_ECAM) selects PCI_HOST_COMMON which has unmet direct dependencies (MMU && PCI)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43721 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170825/22c0e570/attachment-0001.gz>
