From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:22:02 +0800
Subject: [PATCH 14/77] ARM: dts: sunxi: Change default CMA pool node name
In-Reply-To: <1a8583339afbc1e7e3590e5ca134eae2f7284f4f.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <1a8583339afbc1e7e3590e5ca134eae2f7284f4f.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64B5RdDXhzRtexRZnXsugq=s5qPr+JZKSv9R-+QJXPS8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The CMA node has a unit address, but no reg property which generates a
> warning in DTC. Change the node name to reflect its usage and drop the unit
> address.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
