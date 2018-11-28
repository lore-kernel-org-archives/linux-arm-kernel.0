From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:32:36 +0800
Subject: [PATCH 20/77] ARM: dts: sun5i: Remove underscores from nodes names
In-Reply-To: <997f9f1b7437b3bfc42b2f508f1d9ecd34c1e327.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <997f9f1b7437b3bfc42b2f508f1d9ecd34c1e327.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v671_t3K+J7gy3pO23p5nR+xeLTUK59T1E_Q3xwQ_H38zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Some GPIO pinctrl nodes cannot be easily removed, because they would also
> change the pin configuration, for example to add a pull resistor or change
> the current delivered by the pin.
>
> Those nodes still have underscores and unit-addresses in their node names
> in our DTs, so adjust their name to remove the warnings. Use that occasion
> to also fix some poorly chosen node-names.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

But you might want to squash it in with patch 16?
