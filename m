From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 31 Oct 2012 14:40:51 +0100
Subject: [PATCH 0/2] clk: ux500: Add some more clk lookups for u8500
Message-ID: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Some more clock lookups added for rng clocks and for the nomadik ske
keypad clocks.

Ulf Hansson (2):
  clk: ux500: Register rng clock lookups for u8500
  clk: ux500: Register nomadik keypad clock lookups for u8500

 drivers/clk/ux500/u8500_clk.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
1.7.10
