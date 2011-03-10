From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Mar 2011 22:09:30 +0900
Subject: [PATCH v3 0/3] ARM: S5P: Add platform helpers for MIPI-CSIS/DSIM
	DPHY
In-Reply-To: <1299762193-7791-1-git-send-email-s.nawrocki@samsung.com>
References: <1299762193-7791-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <009b01cbdf24$67587c20$36097460$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Hello,
> 
Hi :)

Thanks for your re-submitting.

> the following is a fourth version of a change set adding platform helpers
> for the MIPI-CSIS and MIPI-DSIM PHYs control on S5PV210 and Exynos4.
> 
> Changes since v3:
>  - further copyright change (ptach 1/3)
>  - fixed_phy_vdd type changed to bool (p. 2/3);
> 
> Changes since v2:
>  - renamed setup-mipi.c/setup-mipidphy.c
>  - regs-pmu.h header included in regs-clock.s in mach-exynos4 to get
>    rid of CONFIG_ARCH_EXYNOS4 in setup-mipiphy.c
> 
> Changes since v1:
>  - updated the platform data structure with an additional flag indicating
>    whether the driver should attempt to control the external mipi-csis
>    (VDD18_MIPI) voltage regulator or not. This might be needed on systems
>    where MIPI VDD power supply cannot be separately switched on/off.
> 
> 
> The patch series contains:
>  [PATCH v4 1/3] ARM: S5P: Rename MIPI-CSIS driver header and update
Copyright
>  [PATCH v4 2/3] ARM: S5P: Extend MIPI-CSIS platform_data with the PHY
control
> callback
>  [PATCH v4 3/3] ARM: S5P: Add support for common MIPI CSIS/DSIM D-PHY
control
> 
> Created against for-next branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> 
Looks ok to me, will apply.
Thanks again.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
