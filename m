From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Aug 2017 15:34:35 +0200
Subject: [EXT] Re: [PATCH net-next 03/18] net: mvpp2: set the SMI PHY
 address when connecting to the PHY
In-Reply-To: <7dc117f56c284081b791bceb588a8aa1@IL-EXCH01.marvell.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-4-antoine.tenart@free-electrons.com>
 <20170726160806.GF12049@lunn.ch> <20170728014905.GC24728@kwain>
 <20170728042153.GH18666@lunn.ch>
 <f6d8907b057241c7a72da0a0255cfd23@IL-EXCH01.marvell.com>
 <20170823123424.GA28612@lunn.ch>
 <7dc117f56c284081b791bceb588a8aa1@IL-EXCH01.marvell.com>
Message-ID: <20170823133435.GF28612@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This feature work only for Out-of-Band Auto-Negotiation in SGMII Mode.
> Current GoP(MAC) code configure SGMII In-band Auto-Negotiation performed by the PCS layer
> without PHY polling.

Hi Stefan

So there is no need to configure the address then, leave PHY polling
turned off and we avoid all the issues.

       Andrew
