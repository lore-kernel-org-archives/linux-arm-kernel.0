From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 May 2010 12:23:34 +0200
Subject: [PATCH] Common plat-s5p updates
Message-ID: <1274178216-12003-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series contains some core plat-s5p updates, required for both
plat-s5pc1xx cleanup series as well as patches that add Samsung Aquila
board support. This patch series has been rebased onto next-samsung git
tree.

Changes since the previous version:
- updated copyright header in mach-s5pv210/setup-i2c0.c

This patch series has been sent earlier under the 'Common plat-s5p
fixes' thread.

The series contain the following patches:

[PATCH 1/2] ARM: Samsung: copy common I2C0 device helpers to machine directories
[PATCH 2/2] ARM: Samsung: move driver strength gpio configuration helper to common dir

Best regards,
Marek Szyprowski
