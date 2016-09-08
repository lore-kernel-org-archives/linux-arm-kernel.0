From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Sep 2016 11:13:48 -0700
Subject: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
In-Reply-To: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 8 Sep 2016 09:53:24 +0200")
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2wpimmf8j.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset adds a specific compatible string in the Meson SPIFC driver for
> the Amlogic Meson GXBB SoC.
>
> This patchset is SPI-only respin from Jerome Brunet patchset at [1].
>
> [1] http://lkml.kernel.org/r/1473261223-15412-1-git-send-email-jbrunet at baylibre.com
>
> Neil Armstrong (2):
>   dt-bindings: spi-meson: Add GXBB Compatible string
>   spi: meson: Add GXBB compatible

Acked-by: Kevin Hilman <khilman@baylibre.com>

Mark, with your ack, I could take these through the amlogic tree also.
Let me know.

Kevin
