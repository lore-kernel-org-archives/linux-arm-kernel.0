From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 Sep 2017 18:32:31 +0200
Subject: [PATCH 5/9] arm64: dts: marvell: mcbin: add comphy references to
 Ethernet ports
In-Reply-To: <20170918135217.GE20017@kwain>
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
 <20170918075814.27405-6-antoine.tenart@free-electrons.com>
 <20170918085012.knvnwgouhtjyychn@sapphire.tkos.co.il>
 <20170918130437.GA12118@lunn.ch> <20170918135217.GE20017@kwain>
Message-ID: <20170918163231.GC15606@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We could also add an extra comment without renaming the comphy node, something
> like:
> 
> 	/* Network PHY */
> 	phy = <&ethernet_phy0>;
> 	phy-mode = "10gbase-kr";
> 	/* Generic PHY, providing serdes lanes */
> 	phys = <&cpm_comphy4 0>;

Yes, that is good.

Thanks
	Andrew
