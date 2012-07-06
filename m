From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  6 Jul 2012 15:19:10 +0200
Subject: [PATCH v2 0/2] ARM: OMAP4 SDP/PandaBoard: Fix sys_nirq2 mux
 configuration
Message-ID: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

sys_nirq2 pin needs to be set to mode0 (instead of mode1 done in v1 patches).
To my surprise mode1 also worked, but it was not the correct mode.

I have kept the acks from Santosh since the idea behind of the patches are the
same, but now the mux mode is the correct one.

Regards,
Peter

---
Peter Ujfalusi (2):
  ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
  ARM: OMAP: board-omap4panda: MUX configuration for sys_nirq2

 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

-- 
1.7.8.6
