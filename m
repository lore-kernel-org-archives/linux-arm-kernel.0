From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 16 May 2011 20:10:54 +0200
Subject: [PATCH 0/4] ARM: tegra: paz00 patches for 2.6.40
Message-ID: <1305569458-4821-1-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Collin,

the following patches are intended for 2.6.40 merge. They are mostly similar
to the TrimSlice patches sent by Mike a few days ago.

We are still stuggling with the sound codec (alc5632) and the nvec, so there
is nothing to connect to the i2c yet. On the other hand, I'm wondering what's
up with the atd7461 included in most (all?) boards. It's compatible with lm90,
but the driver will never register because of the wrong name.

May I ask if there is some timeline for framebuffer integration? A netbook
without display is of not much use (ok, same holds for keyboard/mouse).

Thanks!

Marc

Marc Dietrich (4):
  ARM: tegra: paz00: whitespace cleanup
  ARM: tegra: paz00: register i2c busses
  ARM: tegra: paz00: enable usb ports
  ARM: tegra: paz00: cleanup sdhci ports

 arch/arm/mach-tegra/board-paz00-pinmux.c |   10 ++---
 arch/arm/mach-tegra/board-paz00.c        |   72 +++++++++++++++++++++++++----
 arch/arm/mach-tegra/board-paz00.h        |   10 ++---
 3 files changed, 70 insertions(+), 22 deletions(-)

-- 
1.7.4.2
