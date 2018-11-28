From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:34:47 +0800
Subject: [PATCH 55/77] ARM: dts: sun8i: a23/a33: Remove unused
 address-cells/size-cells
In-Reply-To: <6b72724d16bbef52bde66a99641b34a5d3c942ce.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <6b72724d16bbef52bde66a99641b34a5d3c942ce.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67D6y+U4NBm0evwFNTjSGR_+RMm19nOgMTgJ-DqfywySQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The #address-cells and #size-cells are only relevant for nodes that have
> childs with reg properties. Otherwise, DTC will emit a warning saying that
> those properties are unnecessary.
>
> Remove them when needed.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
