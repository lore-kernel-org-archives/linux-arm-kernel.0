From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 24 Jun 2017 07:02:34 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 43/44] make[2]: *** No rule to
 make target 'arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.o', needed by
 'arch/arm64/kvm/kvm.o'.
Message-ID: <201706240733.cJxmM4x8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   bdab51ab2560539213cf4541763326b0caddbda5
commit: fa9a010dcb7fa3e34ee10e9aeb0c112bd863f421 [43/44] WIP
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout fa9a010dcb7fa3e34ee10e9aeb0c112bd863f421
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm-platforms/kvm-arm64/gicv4-kvm HEAD bdab51ab2560539213cf4541763326b0caddbda5 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> make[2]: *** No rule to make target 'arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.o', needed by 'arch/arm64/kvm/kvm.o'.
   make[2]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35223 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170624/2fa08fe7/attachment-0001.gz>
