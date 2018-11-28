From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:28:45 +0800
Subject: [PATCH 48/77] ARM: dts: sun7i: Provide default muxing for
 relevant controllers
In-Reply-To: <eb75e7a19abeba628cb8976882ace5587286ef93.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <eb75e7a19abeba628cb8976882ace5587286ef93.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64jTnYU1jb4SK2WWQHSx0GHTKJa0VHc8gwZy0ct4zHk+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The I2C and MMC controllers have only one muxing option in the SoC. In such a
> case, we can just move the muxing into the DTSI, and remove it from
> the DTS.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
