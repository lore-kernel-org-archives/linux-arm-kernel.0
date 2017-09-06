From: lkp@intel.com (kbuild test robot)
Date: Thu, 7 Sep 2017 04:49:51 +0800
Subject: [PATCH] arm64: KVM: VHE: save and restore some PSTATE bits
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2015DF717@DGGEMA503-MBX.china.huawei.com>
Message-ID: <201709070400.hMXjnfQX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.13 next-20170906]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/gengdongjiu/arm64-KVM-VHE-save-and-restore-some-PSTATE-bits/20170907-013418
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   /tmp/ccT6UpbP.s: Assembler messages:
>> /tmp/ccT6UpbP.s:1415: Error: constant expression required
   /tmp/ccT6UpbP.s:1439: Error: constant expression required
>> /tmp/ccT6UpbP.s:1420: Error: attempt to move .org backwards
   /tmp/ccT6UpbP.s:1444: Error: attempt to move .org backwards

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36347 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170907/e1a08923/attachment-0001.gz>
