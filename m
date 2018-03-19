From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Mar 2018 13:59:53 +0100
Subject: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
In-Reply-To: <20180319125227.GI4519@kwain>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain>
Message-ID: <20180319125953.GD19795@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine

> You guessed right, that's exactly my use case. The DB boards (7k and 8k)
> have 10G interfaces without PHYs.

If they don't have PHYs, how are the connected to the outside world?

   Andrew
