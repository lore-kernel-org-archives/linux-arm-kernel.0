From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 06 Oct 2017 14:24:11 -0700
Subject: [PATCH] ARM64: dts: meson-gxl-libretech-cc: enable saradc
In-Reply-To: <20170905170955.13135-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Tue, 5 Sep 2017 19:09:55 +0200")
References: <20170905170955.13135-1-jbrunet@baylibre.com>
Message-ID: <7hzi947yx0.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Enable saradc and add the reference 1.8v regulator required.
> The libretech-cc has saradc channel 0 and 2 available on the 2 first
> pins of 2J3 header
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Appled to v4.15/dt64,

Kevin
