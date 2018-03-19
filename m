From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Mar 2018 14:24:26 +0100
Subject: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
In-Reply-To: <20180319131343.GK4519@kwain>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain> <20180319125953.GD19795@lunn.ch>
 <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
 <20180319130823.GA22306@lunn.ch> <20180319131343.GK4519@kwain>
Message-ID: <20180319132426.GB26039@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This would definitively work for SFP connectors with a PHY, but would
> that work when using direct attached cable?

Then you need to know what is on the other end of the cable? A switch?
A PHY? and SFP module?

  Andrew
