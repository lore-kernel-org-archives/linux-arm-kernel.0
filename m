From: khilman@ti.com (Kevin Hilman)
Date: Tue, 07 Jun 2011 17:08:27 -0700
Subject: [GIT PULL] GPIO: OMAP fixes for v3.0-rc
Message-ID: <878vtdkww4.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

Here's a small set of OMAP GPIO fixes for v3.0-rc.

Thanks,

Kevin



The following changes since commit 59c5f46fbe01a00eedf54a23789634438bb80603:

  Linux 3.0-rc2 (2011-06-06 18:06:33 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.0/gpio-fixes

Colin Cross (2):
      GPIO: OMAP: fix setting IRQWAKEN bits for OMAP4
      GPIO: OMAP: add locking around calls to _set_gpio_triggering

Russell King (1):
      GPIO: OMAP: fix section mismatch warnings

 drivers/gpio/gpio-omap.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)
