From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:24:11 +0200
Subject: [PATCH 0/3] mfd randconfig fixes
Message-ID: <1402003454-1989084-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel and Lee,

Here are three small bug fixes for problems I found during
randconfig testing in MFD. Please apply to an appropriate
tree.

Arnd Bergmann (3):
  mfd: UCB1x00: enable modular build
  mfd: davinci voicecodec need regmap_mmio
  mfd: STw481x: allow modular build

 drivers/mfd/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.3.2
