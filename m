From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 11:27:13 +0800
Subject: [PATCH v2 6/20] clk: sunxi-ng: mux: Change pre-divider
 application function prototype
In-Reply-To: <b7fab9142ae318f9188b93dfba0b6bd2b530a514.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <b7fab9142ae318f9188b93dfba0b6bd2b530a514.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v672x244T9OWg10Y0+kithOOxn9p1WFipmovDqjZOc4WaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The current function name is a bit confusing, and doesn't really allow to
> create an explicit function to reverse the operation.
>
> We also for now change the parent rate through a pointer, while we don't
> return anything.
>
> In order to be less confusing, and easier to use for downstream users,
> change the function name to something hopefully clearer, and return the
> adjusted rate instead of changing the pointer.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
