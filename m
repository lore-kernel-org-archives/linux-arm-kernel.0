From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 27 Jun 2013 10:53:02 +0900
Subject: [PATCH v3 0/2] ARM: shmobile: r8a7790: add thermal driver support
Message-ID: <1372297984-9315-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series enables the thermal driver on the r8a7790 SoC
and thus the lager board.

It is based on renesas-next-20130620

v3
* Correct title of clocks patch to refer to r8a7790

v2
* Add clocks patch

Simon Horman (2):
  ARM: shmobile: r8a7790: add clocks for thermal
  ARM: shmobile: r8a7790: add thermal driver support

 arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
 arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)

-- 
1.8.2.1
