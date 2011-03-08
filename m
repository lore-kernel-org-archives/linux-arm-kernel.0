From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 Mar 2011 08:05:29 +0900
Subject: [PATCH v2 0/3] ARM: S5P: Add D-PHY control platform helpers for
	MIPI-CSIS/DSIM drivers
In-Reply-To: <1299179061-30959-1-git-send-email-s.nawrocki@samsung.com>
References: <01a701cbd95d$9873c160$c95b4420$%kim@samsung.com>
	<1299179061-30959-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <042301cbdde5$54047a60$fc0d6f20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Hello,
> 
> the following patch series adds the platform helpers for MIPI-CSIS and
MIPI-
> DSIM
> drivers to control their corresponding D-PHYs.
> MIPI-DSIM driver should use its D-PHY control function from
plat-s5p/setup-
> mipi.c.
> 
> Changes since v1:
> - created common setup-mipi.c under plat-s5p for all S5P/EXYNOS4* SoCs
> 
> 
> The patch series contains:
> [PATCH v2 1/3] ARM: S5P: Rename MIPI-CSIS driver header and update
Copyright
> [PATCH v2 2/3] ARM: S5P: Extend MIPI-CSIS platform_data with the PHY
control
> callback
> [PATCH v2 3/3] ARM: S5P: Add support for common MIPI CSIS/DSIM D-PHY
control
> 
Hi Sylwester,

Basically, I agree with your current approach :)

Will review it today and re-think other method about your ifdef(EXYNOS4) so
that can support single kernel later.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
