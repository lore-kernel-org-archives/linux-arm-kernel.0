From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 29 Sep 2014 13:17:45 +0530
Subject: [PATCH v2 0/3] Some cleanup for samsung clock
Message-ID: <1411976868-22209-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does some cleanup of samsung clock files and fixes
one typo in clk.h

Changes since v1:
 - Added patch commit message description to patch 1/3 and 2/3.

Pankaj Dubey (3):
  clk: samsung: Spelling s/bwtween/between/
  clk: samsung: remove unnecessary CONFIG_OF from clk.c
  clk: samsung: remove unnecessary inclusion of header files from clk.h

 drivers/clk/samsung/clk.c |    5 ++---
 drivers/clk/samsung/clk.h |    6 +-----
 2 files changed, 3 insertions(+), 8 deletions(-)

-- 
1.7.9.5
