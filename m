From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 12:23:58 +0100
Subject: [PATCH v2 00/10] mtd: st_spi_fsm: Align with ST's internal development
Message-ID: <1400757848-18075-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian, all,

v2:
  These are the last remaining patches in the set, all rebased and
  with the DT documentation requested after the last submission.

v1:
  This patch-set updates ST's FSM SPI-NOR driver with all the internal
  goodness which has happened since the initial (now upstreamed) snapshot
  was taken. It covers just over 6 months worth of internal development
  and bug-fixes. A final whitespace clean-up is also appended to the set
  - to make it look pretty and stuff. :)

 Documentation/devicetree/bindings/mtd/st-fsm.txt |   2 +
 drivers/mtd/devices/st_spi_fsm.c                 | 687 +++++++++++++++--------
 2 files changed, 469 insertions(+), 220 deletions(-)
