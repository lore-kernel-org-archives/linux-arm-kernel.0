From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  3 Oct 2012 23:38:52 -0700
Subject: [PATCH 0/3] Minor fixes for generic clock framework
Message-ID: <1349332735-20096-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small set of patches that fixes some documentation
and fixes return values of functions that aren't used that
much yet. Noticed while going through this code.

Stephen Boyd (3):
  clk: Document .is_enabled op
  clk: Fix documentation typos
  clk: Don't return negative numbers for unsigned values with !clk

 drivers/clk/clk.c            | 20 ++++++++++----------
 include/linux/clk-provider.h | 16 ++++++++++------
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
