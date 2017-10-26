From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Oct 2017 11:54:11 +0200
Subject: [PATCH v9 04/10] arm: dts: sunxi: h3/h5: represent the mdio
 switch used by sun8i-h3-emac
In-Reply-To: <20171024175714.15840-5-clabbe.montjoie@gmail.com>
References: <20171024175714.15840-1-clabbe.montjoie@gmail.com>
 <20171024175714.15840-5-clabbe.montjoie@gmail.com>
Message-ID: <20171026095411.GJ20299@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 07:57:08PM +0200, Corentin Labbe wrote:
> Since dwmac-sun8i could use either an integrated PHY or an external PHY
> (which could be at same MDIO address), we need to represent this selection
> by a MDIO switch.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
