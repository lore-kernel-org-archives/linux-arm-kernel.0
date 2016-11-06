From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 6 Nov 2016 11:19:37 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161105220848.k6rrjmvvhdaeduma@perseus.defre.kleine-koenig.org>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <20161105210441.GB1216@lunn.ch>
 <20161105220848.k6rrjmvvhdaeduma@perseus.defre.kleine-koenig.org>
Message-ID: <20161106101937.GA9617@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Will do for v2. arch/arm/boot/dts/keystone-* needs fixing in this
> regard, too.

There is a whitelist of compatible strings which are ignored, for
backwards compatibility. See of_mdiobus_child_is_phy(). It would be
nice to fix keystone, but it is not required.

     Andrew
