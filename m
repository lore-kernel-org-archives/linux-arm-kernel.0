From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 8 Apr 2014 21:27:22 +0200
Subject: [PATCH 0/3] ARM: kirkwood: Add device tree for NSA320
In-Reply-To: <5341C91D.4060007@baker-net.org.uk>
References: <5341C91D.4060007@baker-net.org.uk>
Message-ID: <20140408192722.GE29372@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 06, 2014 at 10:37:33PM +0100, Adam Baker wrote:
> As promised here are my sequence of patches to add support for the
> Zyxel NSA 320
> 
> The three patches are as previously discussed
> 
> 1 - Move some things that are common to both nsa310, nsa310a and nsa320 into
>     kirkwood-nsa310-common.dtsi
> 2 - add the dts for nsa320
> 3 - rename kirkwood-nsa310-common.dtsi to kirkwood-nsa3x0-common.dtsi (I suspect
>     the nsa325 is sufficiently different to not share this file). I suggest
>     making this change last as it can easily be dropped till later if it causes
>     conflicts.

Apart from the issue in mentioned in the 3rd patch:

Acked-by: Andrew Lunn <andrew@lunn.ch>
