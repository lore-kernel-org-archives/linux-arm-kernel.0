From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Jul 2017 16:51:01 +0200
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
In-Reply-To: <20170728144424.GB7221@Red>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
 <20170728135544.GD32230@lunn.ch> <20170728142508.GA7221@Red>
 <20170728143600.GB2132@lunn.ch> <20170728144424.GB7221@Red>
Message-ID: <20170728145101.GC2132@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It is too late when we know the PHY ID.
> We need to set a syscon for choosing external/internal PHY.
> So we can rely only on DT.

The point is, its not a property of the PHY. It is a syscon or a MAC
property. Having it as a MAC property would be more generic.

   Andrew
