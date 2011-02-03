From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  3 Feb 2011 15:48:33 -0800
Subject: [PATCHv2 0/3] hvc_dcc cleanups and fixes
In-Reply-To: <20110203221742.GA4159@kroah.com>
References: <20110203221742.GA4159@kroah.com>
Message-ID: <1296776916-21018-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Redone against tty-next and collected acks from Nicolas and Tony.

Stephen Boyd (3):
  hvc_dcc: Fix bad code generation by marking assembly volatile
  hvc_dcc: Simplify put_chars()/get_chars() loops
  hvc_dcc: Simplify assembly for v6 and v7 ARM

 drivers/tty/hvc/hvc_dcc.c |   43 +++++++------------------------------------
 1 files changed, 7 insertions(+), 36 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
