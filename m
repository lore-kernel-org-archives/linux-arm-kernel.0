From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 11:11:42 +0000
Subject: [PATCH 0/5] mtd: st_spi_fsm: Sweep-up remaining blocking-issues
Message-ID: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian,

Sincerest apologies for missing these before.

I hope this now covers all of points you raised.

 drivers/mtd/devices/st_spi_fsm.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)
