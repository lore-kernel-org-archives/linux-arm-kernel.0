From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 10 Jun 2011 12:04:22 +0530
Subject: [PATCH 0/5] ARM: Add SPDIF support for EXYNOS4
Message-ID: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXYNOS4 supports S/PDIF transmitter simillar to the one in S5PV210.

This patchset adds the clock support, fixes improper gpio configs
and enables the device for SMDKV310.

 o To Kukjin Kim, Sangbeom Kim and Seungwhan Youn,
[PATCH 1/5] ARM: EXYNOS4: Add EPLL clock operations
[PATCH 2/5] ARM: EXYNOS4: Add sclk_spdif clocks
[PATCH 3/5] ARM: EXYNOS4: fix improper gpio configuration
[PATCH 4/5] ARM: EXYNOS4: Add SPDIF for SMDKV310

 o To Seungwhan Youn, Jassi Brar, Mark Brown and Liam Girdwood,
[PATCH 5/5] ASoC: SMDKV310: Enable SPDIF device

Best Regards,
Naveen Krishna Chatradhi
