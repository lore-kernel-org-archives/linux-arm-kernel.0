From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 30 Jan 2017 10:50:01 -0800
Subject: [PATCH v4 3/3] ARM64: dts: meson: meson-gx: add the SAR ADC
In-Reply-To: <20170122181714.6259-4-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 22 Jan 2017 19:17:14 +0100")
References: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
 <20170122181714.6259-4-martin.blumenstingl@googlemail.com>
Message-ID: <m2efzktmau.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Add the SAR ADC to meson-gxbb.dtsi and meson-gxl.dtsi. GXBB provides a
> 10-bit ADC while GXL and GXM provide a 12-bit ADC.
> Some boards use resistor ladder buttons connected through one of the ADC
> channels. On newer devices (GXL and GXM) some boards use pull-ups/downs
> to change the resistance (and thus the ADC value) on one of the ADC
> channels to indicate the board revision.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Andreas F?rber <afaerber@suse.de>

Now that IIO driver looks like it will be merged shortly, I applied this
to v4.11/dt64.

Didn't make the first pull request for arm-soc, but may still make it if
I have time to send another batch.

Kevin
