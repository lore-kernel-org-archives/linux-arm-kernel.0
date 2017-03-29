From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Mar 2017 14:57:06 +0200
Subject: [PATCH net-next] net: mvneta: add RGMII_RXID and RGMII_TXID
 support
In-Reply-To: <20170329084226.3472-1-jszhang@marvell.com>
References: <20170329084226.3472-1-jszhang@marvell.com>
Message-ID: <20170329125706.GC28922@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 04:42:26PM +0800, Jisheng Zhang wrote:
> RGMII_RXID and RGMII_TX_ID share the same GMAC CTRL setting as RGMII
> or RGMII_ID.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Looks reasonable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
