From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Jul 2017 16:36:00 +0200
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
In-Reply-To: <20170728142508.GA7221@Red>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
 <20170728135544.GD32230@lunn.ch> <20170728142508.GA7221@Red>
Message-ID: <20170728143600.GB2132@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I've probably asked this before: Does the internal PHY use a different
> > PHY ID in registers 2 and 3?
> > 
> 
> yes
> 
> reg2: 0x0044
> reg3: 0X1500

So this is not about loading the correct PHY driver. You can already
do this based on the PHY IDs...

This is about selecting which PHY to use. Internal or External?	

     Andrew
