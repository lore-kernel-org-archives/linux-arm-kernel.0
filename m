From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Fri, 24 Mar 2017 14:18:59 +0800
Subject: mmc: core: Do not hold re-tuning during CMD6 commands
Message-ID: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Chaotian Jing (1):
  mmc: core: Do not hold re-tuning during CMD6 commands

 drivers/mmc/core/mmc_ops.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
1.7.9.5
