From: lkp@intel.com (kbuild test robot)
Date: Mon, 26 Jun 2017 13:39:24 +0800
Subject: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
In-Reply-To: <20170623220857.28774-2-palmer@dabbelt.com>
Message-ID: <201706261344.OUjMGlsQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Palmer,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.12-rc6]
[cannot apply to next-20170623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Palmer-Dabbelt/pci-Add-and-use-PCI_GENERIC_SETUP-Kconfig-entry/20170626-043558
config: m68k-allnoconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

warning: (M68K) selects PCI_GENERIC_SETUP which has unmet direct dependencies (MMU)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 4487 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/d0028190/attachment.gz>
