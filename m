From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Mar 2014 16:39:14 +0000
Subject: [PATCH 00/15] mtd: st_spi_fsm: Align with ST's internal development
Message-ID: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian, all,

This patch-set updates ST's FSM SPI-NOR driver with all the internal
goodness which has happened since the initial (now upstreamed) snapshot
was taken. It covers just over 6 months worth of internal development
and bug-fixes. A final whitespace clean-up is also appended to the set
- to make it look pretty and stuff. :)

 drivers/mtd/devices/st_spi_fsm.c | 903 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 1 file changed, 579 insertions(+), 324 deletions(-)
