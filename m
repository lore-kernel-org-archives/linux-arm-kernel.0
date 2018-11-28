From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:53:35 +0800
Subject: [PATCH 34/77] ARM: dts: sun6i: Provide default muxing for
 relevant controllers
In-Reply-To: <e6c662ea9e9ed9eecb1c0fa2a48c9bfc32d3802f.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <e6c662ea9e9ed9eecb1c0fa2a48c9bfc32d3802f.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66PVqb0+GGVjNDeTbnw2du3fRVtMm1=w++_x_n1Y+9PzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The I2C and MMC controllers have only one muxing option in the SoC. In such a
> case, we can just move the muxing into the DTSI, and remove it from
> the DTS.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
