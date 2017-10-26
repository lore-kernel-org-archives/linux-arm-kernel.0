From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Oct 2017 11:57:11 +0200
Subject: [PATCH v9 09/10] net: stmmac: dwmac-sun8i: Handle
 integrated/external MDIOs
In-Reply-To: <20171024175714.15840-10-clabbe.montjoie@gmail.com>
References: <20171024175714.15840-1-clabbe.montjoie@gmail.com>
 <20171024175714.15840-10-clabbe.montjoie@gmail.com>
Message-ID: <20171026095711.GK20299@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 07:57:13PM +0200, Corentin Labbe wrote:
> The Allwinner H3 SoC have two distinct MDIO bus, only one could be
> active at the same time.
> The selection of the active MDIO bus are done via some bits in the EMAC
> register of the system controller.
> 
> This patch implement this MDIO switch via a custom MDIO-mux.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
