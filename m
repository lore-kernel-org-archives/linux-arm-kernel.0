From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 23 Jan 2017 10:55:55 -0800
Subject: [PATCH v4 0/9] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 22 Jan 2017 19:10:19 +0100")
References: <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
Message-ID: <m24m0p38sk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This series adds the reset GPIOs for the (external) ethernet PHYs on all
> GXBB boards.
> Additionally it provides a ethernet PHY node which can be used to specify
> PHY-specific properties (this may be required if more boards require the
> "eee-broken-1000t" for the RTL8211F ethernet PHY). To make all board .dts
> consistent I chose to add the PHY node also for boards which don't have a
> RTL8211F PHY.
>
> Patch #7 from this series also removes ethernet support for the P200

I think you mean P201 here, right?

Kevin
