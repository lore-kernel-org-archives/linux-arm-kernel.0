From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 Nov 2012 13:13:07 +0000
Subject: [PATCH 0/3] Input: bu21013_ts - fixups and DT enablement
Message-ID: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grouped together for easy tracking.

 arch/arm/mach-ux500/board-mop500-stuib.c |   71 +-------------------
 drivers/input/touchscreen/bu21013_ts.c   |  105 +++++++++++++++++++++++-------
 include/linux/input/bu21013.h            |    9 +--
 3 files changed, 85 insertions(+), 100 deletions(-)
