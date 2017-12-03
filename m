From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 3 Dec 2017 20:55:58 +0800
Subject: [nomadik:gemini-ethernet-rtl8366rb-jaminit 8/18] ERROR:
 "of_irq_count" [net/dsa/dsa_core.ko] undefined!
Message-ID: <201712032052.TgEQmB0i%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-ethernet-rtl8366rb-jaminit
head:   8c586e6e64b29afb74f775e785aab157d45ff801
commit: 67728777fbf459a4a4541afb18b0a61b5cae4137 [8/18] RFC: net/dsa: Allow DSA PHYs to define link IRQs
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 67728777fbf459a4a4541afb18b0a61b5cae4137
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "of_irq_count" [net/dsa/dsa_core.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42674 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171203/21ae8f6d/attachment-0001.gz>
