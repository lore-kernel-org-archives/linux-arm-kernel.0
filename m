From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Dec 2010 12:08:35 -0800
Subject: [PATCH 0/3] hvc_dcc cleanups and fixes
In-Reply-To: <1292649385-28771-1-git-send-email-sboyd@codeaurora.org>
References: <1292649385-28771-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1292875718-7980-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are the split patches.

The first two patches cleanup and fix the hvc_dcc driver for my
compiler. The final patch is more controversial, it removes the
v6 and v7 differences in this driver.

Stephen Boyd (3):
  hvc_dcc: Fix bad code generation by marking assembly volatile
  hvc_dcc: Simplify put_chars()/get_chars() loops
  hvc_dcc: Simplify assembly for v6 and v7 ARM

 drivers/char/hvc_dcc.c |   43 +++++++------------------------------------
 1 files changed, 7 insertions(+), 36 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
