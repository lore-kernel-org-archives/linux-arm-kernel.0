From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 26 Jan 2015 10:37:36 +0800
Subject: [PATCH v1 0/2] ARM EXYNOS5 & net: add fixed phy support
Message-ID: <1422239858-3452-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches adds fixed phy support using the fixed-link DT binding
for stmmac.

v1:
	- bypassing check on phy id for fixed phy (patch 2/2)

Thanks,
Ming Lei
