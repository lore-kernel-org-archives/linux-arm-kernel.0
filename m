From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 13 Jun 2018 09:21:24 +0200
Subject: [PATCH 1/4] net: emaclite: Fix position of lp->mii_bus assignment
In-Reply-To: <1528871719-1681-2-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528871719-1681-2-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <20180613072124.GB24314@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 12:05:16PM +0530, Radhey Shyam Pandey wrote:
> To ensure MDIO bus is not double freed in remove() path
> assign lp->mii_bus after MDIO bus registration.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
