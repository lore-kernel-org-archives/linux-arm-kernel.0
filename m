From: lkp@intel.com (kbuild test robot)
Date: Tue, 21 Mar 2017 21:51:42 +0800
Subject: [PATCH] kvm: pass the virtual SEI syndrome to guest OS
In-Reply-To: <1489996534-8270-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <201703212147.SBN9HPTf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.11-rc3 next-20170321]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/kvm-pass-the-virtual-SEI-syndrome-to-guest-OS/20170321-152433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   /tmp/ccWmLqCE.s: Assembler messages:
>> /tmp/ccWmLqCE.s:677: Error: selected processor does not support system register name 'vsesr_el2'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53610 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/69b058c2/attachment-0001.gz>
