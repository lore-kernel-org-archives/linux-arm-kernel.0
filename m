From: jeongbae.seo@samsung.com (Jeongbae Seo)
Date: Wed,  6 Oct 2010 15:00:43 +0900
Subject: [PATCH V2 0/3] ARM: S5PV310: Add support HSMMC
Message-ID: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch support HSMMC for S5PV310 and S5PC210.
And addressed comments from Marek.

Changes since v1:
- Added drive strength handling in each SDMMC channel
- Separated to board specific and common changes

[PATCH V2 1/3] ARM: S5PV310: Add support HSMMC and SDHCI configuration
[PATCH V2 2/3] ARM: S5PV310: Add HSMMC platform data
[PATCH V2 3/3] ARM: S5PV310: Add support HSMMC on SMDKV310 and SMDKC210
