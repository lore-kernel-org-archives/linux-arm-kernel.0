From: lkp@intel.com (kbuild test robot)
Date: Fri, 27 Nov 2015 19:49:48 +0800
Subject: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
Message-ID: <201511271919.aEZuZKNe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

[auto build test WARNING on powerpc/next]
[also build test WARNING on v4.4-rc2 next-20151127]
[cannot apply to tip/x86/core]

url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20151127-191620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: mn10300-asb2364_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mn10300 

All warnings (new ones prefixed by >>):

warning: (MN10300) selects HAVE_NMI_WATCHDOG which has unmet direct dependencies (HAVE_NMI)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 8550 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151127/da64a930/attachment.obj>
