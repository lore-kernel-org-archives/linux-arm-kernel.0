From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 28 Feb 2015 11:00:29 +0100
Subject: Bug in i2c-core?
In-Reply-To: <20150227183949.GT7789@pengutronix.de>
References: <54F0507F.6030804@armadeus.com>
 <20150227153725.7404dea1@free-electrons.com>
 <6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
 <20150227170545.GS7789@pengutronix.de>
 <20150227174611.GC6679@dtor-ws>
 <20150227183949.GT7789@pengutronix.de>
Message-ID: <20150228110029.0fab0874@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry, Uwe,

On Fri, 27 Feb 2015 19:39:49 +0100, Uwe Kleine-K?nig wrote:

> > Input is allocated with devm_* and input_register_device knows how to
> > deal with that:
> ah, something new each day. Thanks for teaching me.

Thanks as well, I also discovered that thanks to this discussion.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
