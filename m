From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Dec 2016 22:48:13 +0800
Subject: [PATCH 2/3] sys_mmap64()
In-Reply-To: <1481461003-14361-3-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <201612112221.s0YOV80d%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc8 next-20161209]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yury-Norov/mm-move-argument-checkers-of-mmap_pgoff-to-separated-routine/20161211-211314
config: h8300-h8300h-sim_defconfig (attached as .config)
compiler: h8300-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=h8300 

All errors (new ones prefixed by >>):

>> arch/h8300/kernel/built-in.o:(.data+0x48c): undefined reference to `sys_mmap64'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 4484 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161211/8d970fd7/attachment.gz>
