From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  8 Oct 2010 17:46:19 +0900
Subject: [PATCH 0/2] sdhci-s3c: Add support S5PV310/S5PC210 HSMMC
Message-ID: <1286527581-24903-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support S5PV310/S5PC210 HSMMC and additional host capabilities.
HSMMC of S5PV310 does not have internal clock divider so need to update for it.

Changes since v2:
- Changed clock control method to overriding from using quirk
- This patch is referred from that of Jaehoon Chung's support non-standard clock setting

Changes since v1:
- Separated to each topic

NOTE:
- This patch depends on following.
  [PATCH 4/5] ARM: SAMSUNG : Add clock types into platform data

This includes following.
[PATCH RESEND 1/2] sdhci-s3c: Add support additional host capabilities
[PATCH V3 2/2] sdhci-s3c: Add support no internal clock divider in host controller
