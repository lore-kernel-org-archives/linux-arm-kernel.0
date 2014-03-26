From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Mar 2014 16:06:34 -0700
Subject: [PATCH 0/3] CCF fixlets
Message-ID: <1395875197-16816-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two small changes to clean up the code plus a change to make
driver code simpler.

Stephen Boyd (3):
  clk: Don't check for missing ops in clk_set_parent()
  clk: Consolidate recalc rate logic
  clk: Ignore error and NULL pointers passed to
    clk_{unprepare,disable}()

 drivers/clk/clk.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
