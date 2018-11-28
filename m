From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 11:05:42 +0800
Subject: [PATCH 08/77] ARM: dts: sun5i: Remove redundant
 interrupt-controller
In-Reply-To: <56b1dd7aa2ad7cb02edae229968af30871760899.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <56b1dd7aa2ad7cb02edae229968af30871760899.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64ckTAZDPV3S9SA458HbeBX3V7A3cTK2-8c4JKA3HF8gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The interrupt-parent property is set in sun5i.dtsi, so there's no need to
> repeat it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
