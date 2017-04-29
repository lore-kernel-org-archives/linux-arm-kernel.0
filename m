From: lkp@intel.com (kbuild test robot)
Date: Sun, 30 Apr 2017 07:28:54 +0800
Subject: [PATCH v1 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
In-Reply-To: <1493370634-7038-2-git-send-email-ryder.lee@mediatek.com>
Message-ID: <201704300745.VhwAQyFt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryder,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.11-rc8 next-20170428]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ryder-Lee/Add-PCIe-host-driver-support-for-Mediatek-SoCs/20170429-181028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: s390-allmodconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `mtk_pcie_probe':
>> drivers/pci/host/.tmp_gl_pcie-mediatek.o:(.text+0x5b68c): undefined reference to `pci_fixup_irqs'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45164 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170430/27e2afde/attachment-0001.gz>
