From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:29:02 +0800
Subject: [PATCH 49/77] ARM: dts: sun7i: Remove redundant MMC pinmux tuning
In-Reply-To: <2a975ba9be2960b0d8389c51e2621e922e218f0a.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <2a975ba9be2960b0d8389c51e2621e922e218f0a.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v661W7LQho60pz5TXZtTatcO3VW8GKumXxBdoODx+0bKzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Some boards override the MMC pin muxing settings in order to enable the
> pull-ups and change the drive strength to a value higher than the default.
>
> While this was needed in the earlier days, this is now the default setting
> for those pins, and therefore we don't need those board-specific settings
> anymore.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
