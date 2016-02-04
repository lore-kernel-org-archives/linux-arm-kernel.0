From: lkp@intel.com (kbuild test robot)
Date: Thu, 4 Feb 2016 08:28:53 +0800
Subject: [PATCH 1/4] net: ethernet: dwmac: add Ethernet glue logic for
 stm32 chip
In-Reply-To: <1454511275-9791-2-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <201602040842.LxCCQ6Q3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

[auto build test WARNING on net/master]
[also build test WARNING on v4.5-rc2 next-20160203]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-TORGUE/Add-Ethernet-support-on-STM32F429/20160203-225940
config: um-allyesconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All warnings (new ones prefixed by >>):

warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && DWMAC_STM32 && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 17523 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/cb3c4c9a/attachment-0001.obj>
