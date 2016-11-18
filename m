From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 18 Nov 2016 19:01:40 +0800
Subject: [arm-soc:qcom/arm64 3/13] Error:
 arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi:12.20-21 syntax error
Message-ID: <201611181938.YpOhQOad%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git qcom/arm64
head:   feeaf56ac78d283efe65ea60ec999d4bf3cf395e
commit: 50784e61032d89cbbc46ed73a5fb15f27940b947 [3/13] dts: arm64: db820c: add pmic pins specific dts file
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 50784e61032d89cbbc46ed73a5fb15f27940b947
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi:12.20-21 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31923 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161118/f34100a1/attachment-0001.gz>
