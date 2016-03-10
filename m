From: lkp@intel.com (kbuild test robot)
Date: Thu, 10 Mar 2016 22:43:33 +0800
Subject: [PATCH v2 11/18] pinctrl: Add PLX Technology OXNAS pinctrl and
 gpio driver
In-Reply-To: <1457519060-6038-12-git-send-email-narmstrong@baylibre.com>
Message-ID: <201603102242.MEPUl2xs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.5-rc7]
[cannot apply to next-20160310]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Neil-Armstrong/Add-Initial-support-for-PLX-Technology-OX810SE/20160309-183154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: um-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All warnings (new ones prefixed by >>):

warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_OXNAS && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && COMMON_CLK_OXNAS && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 17787 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160310/26c3135c/attachment.obj>
