From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 19 Aug 2016 15:28:22 -0700
Subject: [PATCH v4 4/6] media: rc: meson-ir: Add support for newer
 versions of the IR decoder
In-Reply-To: <20160819215547.20063-5-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Fri, 19 Aug 2016 23:55:45 +0200")
References: <20160628191802.21227-1-martin.blumenstingl@googlemail.com>
 <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
 <20160819215547.20063-5-martin.blumenstingl@googlemail.com>
Message-ID: <7hy43s5r7d.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> From: Neil Armstrong <narmstrong@baylibre.com>
>
> Newer SoCs (Meson 8b and GXBB) are using REG2 (offset 0x20) instead of
> REG1 to configure the decoder mode. This makes it necessary to
> introduce new bindings so the driver knows which register has to be
> used.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Mauro, are you the one to pick up new media/rc drivers?  Or if you
prefer, with your ack, I'll take this along with the DT and submit via
arm-soc.

Thanks,

Kevin
