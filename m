From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Jun 2012 10:53:24 +0200
Subject: [PATCH v4 5/9] arm: mach-mvebu: add documentation for new device
 tree bindings
In-Reply-To: <1340699313-29331-6-git-send-email-gregory.clement@free-electrons.com>
References: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
 <1340699313-29331-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120626085324.GD25625@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
> @@ -0,0 +1,16 @@
> +MVEBU (Marvell SOCs: Orion, Kirkwood, Dove, Armada 370/XP) System Controller
> +----------------------------------------------------------------------------

Orion5x, not Orion.

and you are missing mv78xx0.

In general, we use Orion to mean the set Orion5x, Dove, Kirkwood, and
mv78xx0.

	Andrew
