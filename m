From: lkp@intel.com (kbuild test robot)
Date: Mon, 11 Sep 2017 11:43:36 +0800
Subject: [PATCH v2 3/5] dmaengine: zynqmp_ps_pcie: Adding PS PCIe DMA
 driver
In-Reply-To: <1504873388-29195-4-git-send-email-vjonnal@xilinx.com>
Message-ID: <201709111147.xUUZAs2e%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ravi,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13 next-20170908]
[cannot apply to xlnx/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ravi-Shankar-Jonnalagadda/dmaengine-ZynqMP-PS-PCIe-DMA-driver/20170911-052150
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Ravi-Shankar-Jonnalagadda/dmaengine-ZynqMP-PS-PCIe-DMA-driver/20170911-052150 HEAD 442a00e11c4fa28ed29541773946aa1cda153e7e builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/dma/xilinx/ps_pcie_platform.o', needed by 'drivers/dma/xilinx/ps_pcie_dma.o'.
   make[4]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56545 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170911/54499dfd/attachment-0001.gz>
