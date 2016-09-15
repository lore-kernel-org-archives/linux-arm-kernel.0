From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 15 Sep 2016 15:10:35 -0700
Subject: [PATCH v2 6/6] ARM64: meson-gxbb-vega-s95: Enable USB Nodes
In-Reply-To: <20160911134111.31141-7-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 11 Sep 2016 15:41:11 +0200")
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-7-martin.blumenstingl@googlemail.com>
Message-ID: <7heg4kke5g.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Enable both gxbb USB controller and add a 5V regulator for the OTG port
> VBUS
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied (after adding a "dts: " to the subject.

Kevin
