From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 1 Nov 2012 15:20:00 +0100
Subject: [PATCH 0/2] Input: nomadik-ske-keypad - clk fixups
Message-ID: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Due to the convert to the common clk driver these changes for clks are needed.

Ulf Hansson (2):
  Input: nomadik-ske-keypad - fixup use of clk
  Input: nomadik-ske-keypad - start using the apb_pclk

 drivers/input/keyboard/nomadik-ske-keypad.c |   34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

-- 
1.7.10
