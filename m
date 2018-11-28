From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:27:26 +0800
Subject: [PATCH 47/77] ARM: dts: sun7i: Fix HDMI output DTC warning
In-Reply-To: <9668c8faee169042aa5cb6dc06f502c6e9ab275d.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <9668c8faee169042aa5cb6dc06f502c6e9ab275d.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64-MJUUWOLzt-STgcfqt-aJOZqhgR91fi6UBEX++0Mzeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our HDMI output endpoint on the A10s DTSI has a warning under DTC: "graph
> node has single child node 'endpoint', #address-cells/#size-cells are not
> necessary". Fix this by removing those properties.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
