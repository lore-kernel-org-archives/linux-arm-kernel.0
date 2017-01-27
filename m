From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Jan 2017 10:10:35 +0100
Subject: [PATCH 0/2] memory: atmel-ebi: Fixes
Message-ID: <1485508237-30178-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are 2 simple EBI fixes to prepare landing of the Atmel NAND
controller driver and bindings rework.

No need to backport them since no one is using the EBI right now.

Nicolas, Alexandre, that'd be great if you could queue it for 4.11
since I plan to take the NAND driver rework for 4.12. If that's not
possible, I'll probably ask you to let me take these fixes into the
NAND tree.

Thanks,

Boris

Boris Brezillon (2):
  memory: atmel-ebi: Fix the test to enable generic SMC logic
  memory: atmel-ebi: Properly handle multiple reference to the same CS

 drivers/memory/atmel-ebi.c | 48 +++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

-- 
2.7.4
