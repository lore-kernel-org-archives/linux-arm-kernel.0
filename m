From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 11:29:53 +0800
Subject: [PATCH 13/77] ARM: dts: sun5i: a10s: Fix HDMI output DTC warning
In-Reply-To: <8279817bd2db6a38dbc27aaef9eb3eb63dcae46c.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <8279817bd2db6a38dbc27aaef9eb3eb63dcae46c.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67sWoGwSm_LCvSTmeu6ksFnXJJNZQNfMt6=gOy0cF+Yqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our HDMI output endpoint on the A10s DTSI has a warning under DTC: "graph
> node has single child node 'endpoint', #address-cells/#size-cells are not
> necessary". Fix this by removing those properties.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
