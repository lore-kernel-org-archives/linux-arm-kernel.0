From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Oct 2013 17:57:29 +0900
Subject: [PATCH 0/2] ARM: shmobile: lager, koelsch: set .debounce_interval
Message-ID: <1383037051-21427-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series sets .debounce_interval for GPIO keys
for the lager and koelsch boards.

This resolves a problem on the lager board reported, tested and fixed by
Kuribayashi-san.  I have extended the solution to the koelsch board.

Shinya Kuribayashi (1):
  ARM: shmobile: lager: set .debounce_interval

Simon Horman (1):
  ARM: shmobile: koelsch: set .debounce_interval

 arch/arm/mach-shmobile/board-koelsch.c | 3 ++-
 arch/arm/mach-shmobile/board-lager.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.8.4
