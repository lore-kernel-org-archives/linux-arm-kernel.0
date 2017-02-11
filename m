From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 11 Feb 2017 23:44:51 +0800
Subject: [nomadik:gemini 28/37] pci-faraday.c:undefined reference to
 `pci_fixup_irqs'
Message-ID: <201702112348.69V0JZBG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini
head:   b07f5b7299d773b7448d92ae002bbfda455daab9
commit: c1ba994d16517166ea1920173566b60c73ac8f18 [28/37] PCI: add driver for Faraday Technology Host Bridge
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout c1ba994d16517166ea1920173566b60c73ac8f18
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `faraday_pci_probe':
>> pci-faraday.c:(.text+0x53ec4): undefined reference to `pci_fixup_irqs'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57922 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170211/fca3d5ab/attachment-0001.gz>
