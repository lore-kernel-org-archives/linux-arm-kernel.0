From: yadi.brar@samsung.com (Yadwinder Singh)
Date: Wed, 09 May 2012 21:54:53 +0530
Subject: [PATCH 0/2] regulator: add initial suport for max77686
Message-ID: <1336580695-1184-1-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for max77686 which is a multifunction device which
includes regulator (pmic), rtc and charger sub-blocks within it. The support for
mfd driver and regulator driver are added by this patch series. This patch series
also includes device tree and irqdomain support for mfd and regulator portions.

Thanks,
Yadwinder Singh
