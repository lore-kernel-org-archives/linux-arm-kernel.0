From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 May 2010 08:29:52 +0200
Subject: Common plat-s5p fixes
Message-ID: <1274077795-30873-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series contains some core plat-s5p fixes, required for both
plat-s5pc1xx cleanup series as well as patches that add Samsung Aquila
board support. This patch series has been rebase onto next-samsung git
tree.

This is a resend of these patches. They were already posted as a part of
other patch series. However most of them are outdated and do not apply
onto the current next-samsung tree.

The series contain the following patches:

[PATCH 1/3] ARM: Samsung: fix broken timer irq base
[PATCH 2/3] ARM: Samsung: move common I2C0 device helpers to machine directories
[PATCH 3/3] ARM: Samsung: move driver strength gpio configuration helper to common dir
