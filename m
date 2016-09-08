From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Sep 2016 17:26:58 +0800
Subject: [PATCH V2 4/4] ARM64 LPC: support earlycon for UART connected to
 LPC
In-Reply-To: <1473255233-154297-5-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201609081710.ReJKhJQT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc5 next-20160908]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Zhichang-Yuan/ARM64-LPC-legacy-ISA-I-O-support/20160907-212837
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `early_hisilpc8250_setup':
>> binder.c:(.init.text+0x479c): undefined reference to `early_serial8250_setup'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51359 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/229e3918/attachment-0001.obj>
