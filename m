From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Nov 2014 22:55:43 +0100
Subject: mvebu: tclk detection for armada-xp and marvell packet processor
 with integrated CPU
In-Reply-To: <546A5714.2090100@alliedtelesis.co.nz>
References: <546959A3.9040206@alliedtelesis.co.nz>
 <20141117093437.0ca5a3ef@free-electrons.com>
 <546A5714.2090100@alliedtelesis.co.nz>
Message-ID: <20141117215543.GC4080@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yeah I'm still trying to wrestle that information out of Marvell. What I 
> do know is for the eval board I've got the armada register SAR (offset 
> 0x18230) is all zeros. I'm not sure if this is because everything really 
> strapped low or because this register is unused on the PP.

Do the CPU SAR pins even make it out of the package? It could be when
the synthesised the CPU they hard coded it all and throw away the SAR.

    Andrew
