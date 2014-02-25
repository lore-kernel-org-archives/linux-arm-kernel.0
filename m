From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 15:35:41 -0500
Subject: [PATCH v3 0/5] mvebu support for kirkwood HP T5325
In-Reply-To: <1393349643-6652-1-git-send-email-andrew@lunn.ch>
References: <1393349643-6652-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140225203541.GE1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Tue, Feb 25, 2014 at 06:33:58PM +0100, Andrew Lunn wrote:
> This patchset adds support to mvebu for the HP T5325 thin client.
> This is the first kirkwood device using device tree which supports
> audio. However the audio codec is missing a device tree binding, and
> simple-audio-card does not yet quite support all the properties needed
> for this hardware. So C code is used for the audio devices.
...

Applied as follows:

> Andrew Lunn (5):
>   ARM: kirkwood: Add audio node to kirkwood.dtsi
>   ARM: kirkwood: Add i2c alias so setting bus number

mvebu/dt

>   ARM: kirkwood: Add HP T5325 thin client

mvebu/soc-kw

>   ARM: kirkwood: Add dts file describing HP T5325 thin client

mvebu/dt

>   ARM: kirkwood: Add HP T5325 devices to {multi|mvebu}_v5_defconfig

mvebu/defconfig

That's one more down!

thx,

Jason.
