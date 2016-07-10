From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Jul 2016 22:32:20 +0200
Subject: [PATCH] ARM: dts: armada-388-clearfog: remove duplicate mdio entry
In-Reply-To: <E1bMGdu-00005c-Dy@rmk-PC.armlinux.org.uk>
References: <E1bMGdu-00005c-Dy@rmk-PC.armlinux.org.uk>
Message-ID: <20160710203220.GA26397@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2016 at 04:27:38PM +0100, Russell King wrote:
> The clearfog DTS should not be defining the on-board phy, this device
> is located on the microsom.  Remove the duplicated definition.
> 
> Reported-by: Jon Nettleton <jon@solid-run.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
