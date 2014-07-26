From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jul 2014 19:20:36 +0200
Subject: [Patch V2 0/2] Generalize use of i2c quirk for Armada XP
Message-ID: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As requested by Arnd, a second patch now removes the documentation of
the -a0 compatibility string.

Acked-by's have been added to the first patch, and a minor nit fixed.

Andrew Lunn (2):
  ARM: mvebu: armada xp: Generalize use of i2c quirk
  i2c: mv64xxx: Remove internal compatible string from Documentation

 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 5 -----
 arch/arm/mach-mvebu/board-v7.c                        | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.0.1
