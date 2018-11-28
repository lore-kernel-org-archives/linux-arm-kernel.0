From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:37:21 +0800
Subject: [PATCH 59/77] ARM: dts: sun8i: a23/a33: Remove all useless
 pinctrl nodes
In-Reply-To: <4f58a58f6076f6a454c98f7bf67001ba2e4e024b.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <4f58a58f6076f6a454c98f7bf67001ba2e4e024b.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67Gok-m+_7bu5HT25+S6nXxcY+eEk9wk7DwqbKcT5ewHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The gpio pinctrl nodes are redundant and as such useless most of the times.
> Since they will also generate warnings in DTC, we can simply remove most of
> them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
