From: david@lechnology.com (David Lechner)
Date: Mon, 14 Mar 2016 17:54:36 -0500
Subject: [PATCH v2 0/5] davinci_mmc fixes
In-Reply-To: <56E6BF7E.7020401@ti.com>
References: <56E6BF7E.7020401@ti.com>
Message-ID: <1457996081-21975-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've updated the patche set based on feedback. This is tested on linux-next with
LEGO MINDSTORMS EV3 (da850), both with and without device tree enabled.

David Lechner (5):
  mmc: davinci: remove matching string
  mmc: davinci: fix unwinding in probe
  mmc: davinci: prepare clock
  mmc: davinci: don't use dma platform resources
  arm: davinci: remove mmc dma resources

 arch/arm/mach-davinci/devices-da8xx.c |  20 ------
 arch/arm/mach-davinci/devices.c       |  16 -----
 drivers/mmc/host/davinci_mmc.c        | 112 +++++++++++-----------------------
 3 files changed, 37 insertions(+), 111 deletions(-)

-- 
1.9.1
