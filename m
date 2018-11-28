From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:29:29 +0800
Subject: [PATCH 50/77] ARM: dts: sun7i: lamobo-r1: Remove unused
 address-cells/size-cells
In-Reply-To: <c0199b0484f2faafce367a0aa1240ca351e48f74.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <c0199b0484f2faafce367a0aa1240ca351e48f74.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66gxGsDZ9JSQq04uBWEr_9aQa9E0Bry9zOhPE0rZdnR+w@mail.gmail.com>
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
