From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jul 2014 23:36:22 +0200
Subject: [PATCH v2 02/12] ARM: Kirkwood: Remove kirkwood_defconfig
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Message-ID: <1405028192-9623-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer needed now that kirkwood lives inside mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/kirkwood_defconfig | 181 ------------------------------------
 1 file changed, 181 deletions(-)
 delete mode 100644 arch/arm/configs/kirkwood_defconfig

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
deleted file mode 100644
index b9e480c10b10..000000000000
-- 
2.0.1
