From: lkp@intel.com (kbuild test robot)
Date: Thu, 19 Nov 2015 08:39:27 +0800
Subject: [PATCH v3 3/5] soc: rockchip: add reboot notifier driver
In-Reply-To: <1447840582-19850-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <201511190859.zI1agDhC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on v4.4-rc1 next-20151118]

url:    https://github.com/0day-ci/linux/commits/Andy-Yan/Add-reboot-notifier-driver-for-rockchip-platform/20151118-181000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

>> WARNING: drivers/soc/built-in.o(.data+0x718): Section mismatch in reference from the variable rockchip_reboot_driver to the function .init.text:rockchip_reboot_probe()
   The variable rockchip_reboot_driver references
   the function __init rockchip_reboot_probe()
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45486 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151119/d84f7a40/attachment-0001.obj>
