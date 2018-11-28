From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:45:37 +0800
Subject: [PATCH 28/77] ARM: dts: sun6i: Remove all useless pinctrl nodes
In-Reply-To: <af84d92ced266a1f2e8eefb194abc5f813884c91.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <af84d92ced266a1f2e8eefb194abc5f813884c91.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67nz3w_caXTOuF9kuhiq2g8k0uY9afBtRD3wv-gP5GitA@mail.gmail.com>
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
