From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Mon, 16 Apr 2018 17:52:44 +0200
Subject: [PATCH v2 0/2] pinctrl/samsung: Fix incorrect EINTG banks order
Message-ID: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series compose of 2 patches.

First patch, fixing incorrect order of banks for s5pv210 and exynos5410

Second patch, documenting required order of banks

Changes from v1:
  - Limit changes to s5pv210 and Exynos5410. Exynos3250 will be handled later.
  - Added cc stable
  - Added fixes tag
  - Add patch with comments to all banks documenting required order.

Pawe? Chmiel (2):
  pinctrl/samsung: Correct EINTG banks order
  pinctrl/samsung: Document required order of banks

 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 30 ++++++++++++++++++++++++--
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 20 +++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.7.4
