From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Aug 2016 17:07:17 +0800
Subject: [PATCH v5 7/8] PM / devfreq: rockchip: add devfreq driver for
 rk3399 dmc
In-Reply-To: <1470799604-12877-8-git-send-email-hl@rock-chips.com>
Message-ID: <201608101609.HEnGzRxN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

[auto build test ERROR on v4.8-rc1]
[also build test ERROR on next-20160809]
[cannot apply to rockchip/for-next devfreq/for-rafael linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/rk3399-support-ddr-frequency-scaling/20160810-114433
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "arm_smccc_smc" [drivers/devfreq/rk3399_dmc.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55524 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160810/04ceb920/attachment-0001.obj>
