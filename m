From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 24 Jan 2013 11:22:51 +0530
Subject: [GIT PULL for v3.8-rc] DaVinci media fixes for v3.8
Message-ID: <CA+V-a8tndm7LJiCfQqPSa6iSxiJ1UmWL-tbxBWh9HiLvvDPwMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Please pull the following patches which fixes display on DA850 EVM . To
avoid conflicts I have included a arm patch, which has been Acked by
its maintainer.

Fixes :
     - adv7343 encoder: fix configuring the encoder.
     - da850: pass data for adv7343 encoder for required configuration.

Thank you!
Prabhakar

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:
  git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git davinci_media

Lad, Prabhakar (2):
      media: adv7343: accept configuration through platform data
      ARM: davinci: da850 evm: pass platform data for adv7343 encoder

 arch/arm/mach-davinci/board-da850-evm.c |   13 ++++++++
 drivers/media/i2c/adv7343.c             |   36 ++++++++++++++++++---
 include/media/adv7343.h                 |   52 +++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 5 deletions(-)
