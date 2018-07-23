From: lkp@intel.com (kbuild test robot)
Date: Tue, 24 Jul 2018 07:13:35 +0800
Subject: [PATCH 1/5] mfd: rk808: Add RK817 and RK809 support
In-Reply-To: <1532315945-1094-2-git-send-email-tony.xie@rock-chips.com>
References: <1532315945-1094-2-git-send-email-tony.xie@rock-chips.com>
Message-ID: <201807240750.KeFSxKL9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ljones-mfd/for-mfd-next]
[also build test ERROR on v4.18-rc6 next-20180723]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tony-Xie/mfd-rk808-Add-RK817-and-RK809-support/20180724-040547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: i386-randconfig-a0-201829 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "pm_power_off_prepare" [drivers/mfd/rk808.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28749 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/844019f7/attachment-0001.gz>
