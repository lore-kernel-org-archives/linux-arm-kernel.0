From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 31 Jul 2017 16:05:02 +0200
Subject: [PATCH 0/2] clk: meson: expose clk ids
In-Reply-To: <20170731113832.26490-1-jbrunet@baylibre.com>
References: <20170731113832.26490-1-jbrunet@baylibre.com>
Message-ID: <CAK8P3a28nb8QsJC8V4+SJM0gz70BDOv8jAczRWoCF+HfvkwJfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 1:38 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> In previous cycles, concerns have been raised about the way clocks are
> exposed for the meson clock controller, only when validated and required
> in DT.
>
> Instead, this patchset expose all the known clocks which may be needed in
> DT later on. The clocks left out are internal clocks which should never be
> used directly in DT. These are mostly internal muxes and dividers of
> composite clocks.
>
> While this should reduce the patch flow on the related header files, It
> won't stop it completely. There are still many clocks we don't know about
> yet. We tend discover a few in every cycle.
>
> This patchset depends on these fixes [0] to avoid issues when adding new
> clk ids.
>
> [0]: https://lkml.kernel.org/r/20170727161755.10393-1-jbrunet at baylibre.com

Thanks a lot!

 Acked-by: Arnd Bergmann <arnd@arndb.de>
