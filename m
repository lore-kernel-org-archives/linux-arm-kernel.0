From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 12 Sep 2018 21:40:35 -0700
Subject: [PATCH v3 3/3] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
In-Reply-To: <20180823114954.30704-4-mjourdan@baylibre.com> (Maxime Jourdan's
 message of "Thu, 23 Aug 2018 13:49:54 +0200")
References: <20180823114954.30704-1-mjourdan@baylibre.com>
 <20180823114954.30704-4-mjourdan@baylibre.com>
Message-ID: <7hworqvwl8.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> DMC is a small memory region with various registers,
> including the ones needed for the canvas module.
>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>

Applied to v4.20/dt64 with s/ARM64/arm64/ as requested.

Thanks,

Kevin
