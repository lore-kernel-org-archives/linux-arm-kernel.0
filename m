From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:00:53 +0800
Subject: [PATCH 39/77] ARM: dts: sun7i: Remove all useless pinctrl nodes
In-Reply-To: <6fdd9b5d257601d88a8deb13727b6309c6c75fce.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <6fdd9b5d257601d88a8deb13727b6309c6c75fce.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64XmhcjOU0qdtGWkeTuvi4jzaZyJehdXxKv7gavmAHobg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The gpio pinctrl nodes are redundant and as such useless most of the times.
> Since they will also generate warnings in DTC, we can simply remove most of
> them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
