From: lkp@intel.com (kbuild test robot)
Date: Sat, 21 Jan 2017 07:21:41 +0800
Subject: [PATCH 2/3] PCI: imx6: Allow probe deferal by reset GPIO
In-Reply-To: <20170119163631.10668-3-andrew.smirnov@gmail.com>
Message-ID: <201701210724.IVdtuzi6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.10-rc4 next-20170120]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/PCI-imx6-Fix-a-typo-in-error-message/20170120-163928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> WARNING: drivers/built-in.o(.data+0x6948c): Section mismatch in reference from the variable imx6_pcie_driver to the function .init.text:imx6_pcie_probe()
   The variable imx6_pcie_driver references
   the function __init imx6_pcie_probe()
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59710 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170121/dde03670/attachment-0001.gz>
