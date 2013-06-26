From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Jun 2013 17:40:38 +0900
Subject: [PATCH v2 0/2] ARM: shmobile: r8a7790: add thermal driver support
Message-ID: <1372236040-16737-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series enables the thermal driver on the r8a7790 SoC
and thus the lager board.

It is based on renesas-next-20130620

Simon Horman (2):
  ARM: shmobile: r8a7790: add thermal driver support
  ARM: shmobile: r8a73a4: add clocks for thermal

 arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
 arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)

-- 
1.8.2.1
