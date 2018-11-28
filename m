From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:34:36 +0800
Subject: [PATCH 54/77] ARM: dts: sun8i: a23/a33: Fix OPP DTC warnings
In-Reply-To: <631bd03061018debc815db896445087b8fc2571c.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <631bd03061018debc815db896445087b8fc2571c.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67jG2fThbtLgKokPV=jQZGjmci5R40KCUJFy82g1Jcw8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> DTC will emit a warning on our OPPs nodes for the common DTSI between the
> A23 and A33 since those nodes use the frequency as unit addresses, but
> don't have a matching reg property.
>
> Fix this by moving the frequency to the node name instead.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
