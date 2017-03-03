From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 3 Mar 2017 19:21:12 +0100
Subject: [PATCH] ARM: DTS armada: Add support for 2 more mvebu model
In-Reply-To: <CA+_ehUx0wcbfHMzPYehbEpQNu-a6vpHqHYJ4U7TY4BkzkLsRBw@mail.gmail.com>
References: <1488560855-421-1-git-send-email-ansuelsmth@gmail.com>
 <20170303172638.GD1488@lunn.ch>
 <CA+_ehUx0wcbfHMzPYehbEpQNu-a6vpHqHYJ4U7TY4BkzkLsRBw@mail.gmail.com>
Message-ID: <20170303182112.GE1488@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 06:41:30PM +0100, Ansuel Smith wrote:
> What you mean? There are some changes with leds for shelby and lots of
> changes about rom size and led for rango.

Hi Ansuel

armada-385-linksys.dtsi does not contain any LEDs at
all. armada-385-linksys-caiman.dts etc, define the LEDs specific to
that board. You can do the same for Rango.

Yes, the flash layout is different. So refactor that into another
.dtsi file, which caiman and cobra can use.

You should be trying to place as much common stuff as possible into
.dtsi files. Which might need a bit of refactoring.

      Thanks
	Andrew
