From: lkp@intel.com (kbuild test robot)
Date: Fri, 27 Nov 2015 02:50:59 +0800
Subject: [PATCH v6 3/6] watchdog: ts4800: add driver for TS-4800 watchdog
In-Reply-To: <1448479507-1951-4-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <201511270217.599Myf2h%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Damien,

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on v4.4-rc2 next-20151126]

url:    https://github.com/0day-ci/linux/commits/Damien-Riegel/of-add-vendor-prefix-for-Technologic-Systems/20151126-033639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: um-allyesconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All warnings (new ones prefixed by >>):

warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && TS4800_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 17129 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151127/203f3e6d/attachment-0001.obj>
