From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 5 Nov 2016 22:23:26 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161105203841.9661-1-uwe@kleine-koenig.org>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
Message-ID: <20161105212326.GC1216@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Still missing is support for the switch.

Is it a Marvell Switch? armada-370-rd.dts would be a good start for
the old binding? vf610-zii-dev-rev-b.dts uses the new binding.

> SFP is untested as is UART1.

UART would be unusual. They are normally i2c.

> Do I need to "register" turris in vendor-prefixes.txt for that?

Yes please.

    Andrew
