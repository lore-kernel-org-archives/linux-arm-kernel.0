From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 15 Sep 2016 15:10:23 -0700
Subject: [PATCH v2 4/6] ARM64: meson-gxbb: add USB Nodes
In-Reply-To: <20160911134111.31141-5-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 11 Sep 2016 15:41:09 +0200")
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-5-martin.blumenstingl@googlemail.com>
Message-ID: <7hintwke5s.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Add the nodes for the dwc2 USB controller and the related USB PHYs.
> Currently we force usb0 to host mode because OTG is currently not
> working in our PHY driver.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied (after adding a "dts: " to the subject.

Kevin
