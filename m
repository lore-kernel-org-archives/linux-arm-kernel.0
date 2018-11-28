From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:46:45 +0800
Subject: [PATCH 30/77] ARM: dts: sun6i: Remove redundant MMC pinmux tuning
In-Reply-To: <f0fedb9e722eb18306d0a33e7997f90910417b17.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f0fedb9e722eb18306d0a33e7997f90910417b17.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64TnAO24=ZERUULutkuL+Ex2QGmxhMyj-e_mU7uMhYVhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
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
