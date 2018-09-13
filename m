From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 12 Sep 2018 21:46:14 -0700
Subject: [PATCH v3 2/3] soc: amlogic: add meson-canvas driver
In-Reply-To: <20180823114954.30704-3-mjourdan@baylibre.com> (Maxime Jourdan's
 message of "Thu, 23 Aug 2018 13:49:53 +0200")
References: <20180823114954.30704-1-mjourdan@baylibre.com>
 <20180823114954.30704-3-mjourdan@baylibre.com>
Message-ID: <7hr2hyvwbt.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> Amlogic SoCs have a repository of 256 canvas which they use to
> describe pixel buffers.
>
> They contain metadata like width, height, block mode, endianness [..]
>
> Many IPs within those SoCs like vdec/vpu rely on those canvas to read/write
> pixels.
>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>

Applied patches 1,2 to v4.20/drivers and added an
"amlogic-drivers-canvas" tag as requested.

Kevin
