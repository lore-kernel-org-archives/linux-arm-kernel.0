From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:13:51 +0800
Subject: [PATCH 46/77] ARM: dts: sun7i: Remove underscores from nodes names
In-Reply-To: <a428495b460780df6cfd6fb678ce8d15bb247448.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <a428495b460780df6cfd6fb678ce8d15bb247448.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v6618cAfJrX2cJ751R11V9Y-14=GOMqGrFcODvFG3yoUvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
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
