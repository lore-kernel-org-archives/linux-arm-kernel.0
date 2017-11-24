From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 24 Nov 2017 12:25:27 +0530
Subject: [PATCH 0/6] clk: pr_err() strings should end with newlines
Message-ID: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Arvind Yadav (6):
  [PATCH 1/6] clk: stm32f4: pr_err() strings should end with newlines
  [PATCH 2/6] clk: lpc32xx: pr_err() strings should end with newlines
  [PATCH 3/6] clk: SPEAr: pr_err() strings should end with newlines
  [PATCH 4/6] SPEAr: clk: pr_err() strings should end with newlines
  [PATCH 5/6] clk: h8s2678: pr_err() strings should end with newlines
  [PATCH 6/6] clk: h8300: pr_err() strings should end with newlines

 drivers/clk/clk-stm32f4.c          | 2 +-
 drivers/clk/h8300/clk-div.c        | 4 ++--
 drivers/clk/h8300/clk-h8s2678.c    | 6 +++---
 drivers/clk/nxp/clk-lpc32xx.c      | 4 ++--
 drivers/clk/spear/clk-frac-synth.c | 2 +-
 drivers/clk/spear/clk-gpt-synth.c  | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1
