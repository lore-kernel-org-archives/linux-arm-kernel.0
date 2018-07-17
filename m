From: lkp@intel.com (kbuild test robot)
Date: Tue, 17 Jul 2018 09:31:59 +0800
Subject: [nomadik:gemini-dir-685-rtl8366rb-rtk-tag 14/14] make[3]: *** No
 rule to make target 'net/dsa/tag_rtk.o', needed by 'net/dsa/built-in.a'.
Message-ID: <20180717013159.GR10593@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-rtl8366rb-rtk-tag
head:   17c7eb1fa8546c38fe844166efb2ece4d1503e7d
commit: 17c7eb1fa8546c38fe844166efb2ece4d1503e7d [14/14] dsa: tagging stab
config: openrisc-allyesconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 17c7eb1fa8546c38fe844166efb2ece4d1503e7d
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 
:::::: branch date: 16 hours ago
:::::: commit date: 16 hours ago

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'net/dsa/tag_rtk.o', needed by 'net/dsa/built-in.a'.
   make[3]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45600 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/03f32fac/attachment-0001.gz>
