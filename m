From: lkp@intel.com (kbuild test robot)
Date: Tue, 17 Jul 2018 09:31:32 +0800
Subject: [nomadik:gemini-dir-685-rtl8366rb-rtk-tag 14/14] make[3]: *** No
 rule to make target 'net/dsa/tag_rtk.o', needed by 'net/dsa/dsa_core.o'.
Message-ID: <20180717013132.GQ10593@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-rtl8366rb-rtk-tag
head:   17c7eb1fa8546c38fe844166efb2ece4d1503e7d
commit: 17c7eb1fa8546c38fe844166efb2ece4d1503e7d [14/14] dsa: tagging stab
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 17c7eb1fa8546c38fe844166efb2ece4d1503e7d
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 
:::::: branch date: 16 hours ago
:::::: commit date: 16 hours ago

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'net/dsa/tag_rtk.o', needed by 'net/dsa/dsa_core.o'.
   make[3]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66187 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/e5da1b6f/attachment-0001.gz>
