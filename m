From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 25 Nov 2016 13:41:02 +0000
Subject: [PATCH v2 0/7] stmmac: dwmac-meson8b: configurable RGMII TX delay
In-Reply-To: <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0228643@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Blumenstingl
> Sent: 25 November 2016 13:02
> Currently the dwmac-meson8b stmmac glue driver uses a hardcoded 1/4
> cycle TX clock delay. This seems to work fine for many boards (for
> example Odroid-C2 or Amlogic's reference boards) but there are some
> others where TX traffic is simply broken.
> There are probably multiple reasons why it's working on some boards
> while it's broken on others:
> - some of Amlogic's reference boards are using a Micrel PHY
> - hardware circuit design
> - maybe more...
...

Interesting thought.
Can you test phy loopback with different delays?
It might be then possible to default to 'auto'.

	David
