From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 13:43:35 -0800
Subject: [PATCH 2/2] ARM64: dts: meson-gx: add the missing uart_AO_B
In-Reply-To: <20170115222029.8271-3-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 15 Jan 2017 23:20:29 +0100")
References: <20170115222029.8271-1-martin.blumenstingl@googlemail.com>
 <20170115222029.8271-3-martin.blumenstingl@googlemail.com>
Message-ID: <m2shogyrg8.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This adds the missing node for the uart_AO_B port to the meson-gx.dtsi
> (as this is supported by GXBB, GXL and GXM) along with the required
> pinctrl pins. This is required as some boards are using it (the boards
> from the Khadas VIM series for example have it exposed on the pin
> headers).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to v4.11/dt64.

Kevin
