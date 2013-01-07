From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 07 Jan 2013 18:35:41 +0800
Subject: [stericsson:ux500-multiplatform 1/1] warning: (ARCH_BCM &&
 UX500_SOC_COMMON && SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects
 ARM_ERRATA_754322 which has unmet direct dependencies (CPU_V7)
Message-ID: <50eaa4fd.vbg6otCIlpmFfQJ7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-multiplatform
head:   661989c3ec725370271a2c00a2e5ab5a88f6b440
commit: 661989c3ec725370271a2c00a2e5ab5a88f6b440 [1/1] ARM: ux500: convert to multiplatorm
config: make ARCH=arm allnoconfig

All warnings:

warning: (UX500_SOC_COMMON) selects PINCTRL_NOMADIK which has unmet direct dependencies (PINCTRL && (ARCH_U8500 || ARCH_NOMADIK))
warning: (UX500_SOC_COMMON && MACH_NOMADIK_8815NHK) selects CLKSRC_NOMADIK_MTU which has unmet direct dependencies (ARCH_NOMADIK || ARCH_U8500)
warning: (ARCH_BCM && UX500_SOC_COMMON && SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_754322 which has unmet direct dependencies (CPU_V7)
warning: (UX500_SOC_COMMON) selects PINCTRL_NOMADIK which has unmet direct dependencies (PINCTRL && (ARCH_U8500 || ARCH_NOMADIK))
warning: (UX500_SOC_COMMON && MACH_NOMADIK_8815NHK) selects CLKSRC_NOMADIK_MTU which has unmet direct dependencies (ARCH_NOMADIK || ARCH_U8500)
warning: (ARCH_BCM && UX500_SOC_COMMON && SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_754322 which has unmet direct dependencies (CPU_V7)
--
warning: (UX500_SOC_COMMON) selects PINCTRL_NOMADIK which has unmet direct dependencies (PINCTRL && (ARCH_U8500 || ARCH_NOMADIK))
warning: (UX500_SOC_COMMON && MACH_NOMADIK_8815NHK) selects CLKSRC_NOMADIK_MTU which has unmet direct dependencies (ARCH_NOMADIK || ARCH_U8500)
warning: (ARCH_BCM && UX500_SOC_COMMON && SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_754322 which has unmet direct dependencies (CPU_V7)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
