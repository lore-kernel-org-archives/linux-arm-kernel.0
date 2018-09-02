From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 2 Sep 2018 20:21:32 +0200
Subject: [PATCH net-next v2 2/3] net: mvneta: enable NETIF_F_RXCSUM by
 default
In-Reply-To: <20180831161003.3f0dc351@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
 <20180831161003.3f0dc351@xhacker.debian>
Message-ID: <20180902182132.GA18764@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 04:10:03PM +0800, Jisheng Zhang wrote:
> The code and HW supports NETIF_F_RXCSUM, so let's enable it by default.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Hi Jisheng

I ran some quick tests on a 370RD devel board, which uses a Marvell
switch connected to mvneta. I did no see any obvious regressions.

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
