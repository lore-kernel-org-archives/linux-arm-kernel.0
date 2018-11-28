From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:42:29 +0800
Subject: [PATCH 66/77] ARM: dts: sun8i: a23/a33: Provide default muxing
 for relevant controllers
In-Reply-To: <09a0b2b3db79496027cf0c5d1f66b0b0259b76e3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <09a0b2b3db79496027cf0c5d1f66b0b0259b76e3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66ZFD_v5KCCj3DZ1xqoCjBvEUOXrDbMWepdJr7zOt35Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The I2C's and MMC0 controllers have only one muxing option in the SoC. In
> such a case, we can just move the muxing into the DTSI, and remove it from
> the DTS.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
