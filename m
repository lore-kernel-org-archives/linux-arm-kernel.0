From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 13 Jun 2018 09:23:01 +0200
Subject: [PATCH 2/4] net: emaclite: Fix MDIO bus unregister bug
In-Reply-To: <1528871719-1681-3-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528871719-1681-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <20180613072301.GC24314@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 12:05:17PM +0530, Radhey Shyam Pandey wrote:
> Since 'has_mdio' flag is not used,sequence insmod->rmmod-> insmod
> leads to failure as MDIO unregister doesn't happen in .remove().
> Fix it by checking MII bus pointer instead.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
