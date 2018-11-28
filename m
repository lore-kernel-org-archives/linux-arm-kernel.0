From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:41:00 +0800
Subject: [PATCH 25/77] ARM: dts: sun6i: Remove SoC node unit-name to avoid
 warnings
In-Reply-To: <c7e0a1601f98d7b1a6262784c67cd272d7117f96.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <c7e0a1601f98d7b1a6262784c67cd272d7117f96.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66gxk03gKa0kVPmqda3+U0Q5DnK+z+1a8K96VKcayNxOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our main node for all the in-SoC controllers used to have a unit name. The
> unit-name, in addition to being actually false, would not match any reg
> property, which generates a warning.
>
> Remove it in order to remove those warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
