From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 23 Jan 2015 10:41:31 +0800
Subject: [PATCH 0/2] ARM & NET: add fixed phy support on stmmac
Message-ID: <1421980893-14475-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EXYNOS5440 sd5v1(arch/arm/boot/dts/exynos5440-sd5v1.dts) has
one stmmc gmac which uses fixed phy, so add fixed phy support for
both EXYNOS5440 and stmmac.

Thanks,
Ming Lei
