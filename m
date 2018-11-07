From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Wed,  7 Nov 2018 21:17:43 +0100
Subject: [PATCH 0/3] ARN: OMAP1: ams-delta: Post-GPIO-refresh cleanups
Message-ID: <20181107201746.14705-1-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Janusz Krzysztofik (3):
      ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
      ARM: OMAP1: ams-delta: Drop unused symbols from the board header
      ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file

 board-ams-delta.c |    9 ++++-----
 board-ams-delta.h |   22 ----------------------
 2 files changed, 4 insertions(+), 27 deletions(-)
