From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Jul 2012 09:01:53 +0200
Subject: [PATCH 6/7] arm: mmp&dove: modify tauros2_init call
Message-ID: <20120731070153.GA13777@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chao

When making changes to Dove, or any other Orion system, please could
you CC: the orion maintainers:

ARM/Marvell Dove/Kirkwood/MV78xx0/Orion SOC support
M:      Jason Cooper <jason@lakedaemon.net>
M:      Andrew Lunn <andrew@lunn.ch>
L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
S:      Maintained
F:      arch/arm/mach-dove/
F:      arch/arm/mach-kirkwood/
F:      arch/arm/mach-mv78xx0/
F:      arch/arm/mach-orion5x/
F:      arch/arm/plat-orion/

Does this also affect Armada 370 and Armada XP SOC? I've no idea what
cache it uses.

Thanks
	Andrew
