From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:05:46 +0200
Subject: [PATCH 0/3] pcmcia randconfig fixes
Message-ID: <1402002349-1984057-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are three small bug fixes for ancient build bugs from
my randconfig queue. No urgency here, but I'm unsure who would
pick them up these days, since there doesn't seem to be anyone
left sending pull requests for pcmcia.

Arnd Bergmann (3):
  pcmcia: journada720: use sa1100 pin interfaces correctly
  pcmcia: pxa2xx: fix logic for lubbock
  pcmcia: sa1100: H3100 and H3600 share a driver

 drivers/pcmcia/Kconfig             |  2 +-
 drivers/pcmcia/Makefile            |  1 +
 drivers/pcmcia/sa1111_jornada720.c | 10 ++++++----
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
1.8.3.2
