From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 10:53:22 +0800
Subject: [PATCH 02/77] ARM: dts: sun4i: Fix HDMI output DTC warning
In-Reply-To: <f94e560d48baed0c5d9932eec1102c1fe76ff29d.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f94e560d48baed0c5d9932eec1102c1fe76ff29d.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v659iC4jTAm7J4+p5vWSSUT5ndjAR69OvKNd+QcPoC1ZmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our HDMI output endpoint on the A10 DTSI has a warning under DTC: "graph
> node has single child node 'endpoint', #address-cells/#size-cells are not
> necessary". Fix this by removing those properties.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
