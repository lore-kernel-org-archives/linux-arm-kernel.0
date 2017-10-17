From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue, 17 Oct 2017 16:38:32 +0200
Subject: [PATCH 0/2] CLK: SPEAr: make structure field,
 function arg and strutcure const
Message-ID: <1508251114-7042-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make structure field and function argument as const. After this change, 
make the structures as const.

Bhumika Goyal (2):
  CLK: SPEAr: make structure field and function argument as const
  CLK: SPEAr: make aux_clk_masks structures const

 drivers/clk/spear/clk-aux-synth.c   | 4 ++--
 drivers/clk/spear/clk.h             | 4 ++--
 drivers/clk/spear/spear1310_clock.c | 2 +-
 drivers/clk/spear/spear1340_clock.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1
