From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 27 Sep 2014 11:11:56 +0530
Subject: [PATCH 0/3] Some cleanup for samsung clock
Message-ID: <1411796519-19417-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does some cleanup of samsung clock files and fixes
one typo in clk.h

Pankaj Dubey (3):
  clk: samsung: Spelling s/bwtween/between/
  clk: samsung: remove unnecessary CONFIG_OF from clk.c
  clk: samsung: remove unnecessary inclusion of header files from clk.h

 drivers/clk/samsung/clk.c |    5 ++---
 drivers/clk/samsung/clk.h |    6 +-----
 2 files changed, 3 insertions(+), 8 deletions(-)

-- 
1.7.9.5
