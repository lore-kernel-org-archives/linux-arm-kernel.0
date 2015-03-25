From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Mar 2015 23:36:52 +0100
Subject: [PATCH] ARM: mvebu: GPIO reset on GlobalScale Mirabox
In-Reply-To: <551333D2.8080600@free-electrons.com>
References: <1427319230-2500-1-git-send-email-leigh@solinno.co.uk>
 <551333D2.8080600@free-electrons.com>
Message-ID: <20150325223652.GC31858@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks for your contribution, however the reset button is not always
> connected to this GPIO. At least on the Mirabox I have the reset button
> triggers an hardware reset. My concern is that for some board the dts
> representation would be wrong.

When looking at WiFi issues, it became clear there are two different
wifi designs. I would not be too surprised if this reset button
changed at the same time.

Gregory, Leigh, is your wifi on the SDIO bus, or the USB bus?

The mirabox i have has an sdio wifi device. But i cannot easily test
the reset button, i blew the 5v power rail, so all USB is dead, and my
rootfs was on mmc, which is implemented via USB :-(

       Andrew
