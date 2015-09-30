From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 1 Oct 2015 04:32:46 +0800
Subject: [arm-platforms:irq/msi-parent-v2 3/4] undefined reference to
 `of_msi_get_domain'
Message-ID: <201510010445.XJOyJCg9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/msi-parent-v2
head:   0d537e9ee95ada0563c90e6fb310e256eaa34db3
commit: 868623d0a5560dc77c594018b84720a7e235c025 [3/4] PCI/MSI: Use of_msi_get_domain instead of open-coded "msi-parent" parsing
config: sparc-allmodconfig (attached as .config)
reproduce:
  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout 868623d0a5560dc77c594018b84720a7e235c025
  # save the attached .config to linux build tree
  make.cross ARCH=sparc 

All error/warnings (new ones prefixed by >>):

   drivers/built-in.o: In function `pci_host_bridge_of_msi_domain':
>> (.text+0x24224): undefined reference to `of_msi_get_domain'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43409 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/0a84a9d1/attachment-0001.obj>
