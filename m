From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 16:41:33 +0200
Subject: SATA working on 370/XP, Ethernet next...
Message-ID: <20120720144133.GA15606@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian

Good to hear you got SATA working. What was wrong?

I'm interested in Ethernet. I assume it uses
drivers/net/ethernet/marvell/mv643xx_eth.c?

If so, your work should be applicable for all Orion devices, and i'm
happy to test on kirkwood.

      Andrew
