From: balbi@ti.com (Felipe Balbi)
Date: Thu, 1 Aug 2013 15:12:42 +0300
Subject: [RFC/PATCH 0/3] arm: omap: patches from -rt
Message-ID: <1375359165-8411-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the next three patches were taken from v3.10.4-rt1 patchset.

I don't have any boards available to test them, so I'd suggest
testing in as many platforms as possible before pushing
upstream.

By pushing these patches upstream, we help decrease the amount
of out-of-tree changes rt folks need to carry.

Frank Rowand (1):
  arm: omap: convert omap boot_lock to raw

Sebastian Andrzej Siewior (1):
  i2c/omap: drop the lock hard irq context

Thomas Gleixner (1):
  serial: omap: fix omap lock crap

 arch/arm/mach-omap2/omap-smp.c   | 10 +++++-----
 drivers/i2c/busses/i2c-omap.c    |  5 +----
 drivers/tty/serial/omap-serial.c | 12 ++++--------
 3 files changed, 10 insertions(+), 17 deletions(-)

-- 
1.8.3.4.840.g6a90778
