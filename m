From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:10:54 +0800
Subject: [PATCH 43/77] ARM: dts: sun7i: Change pinctrl nodes to avoid
 warning
In-Reply-To: <957b3c14ba05e6658aa767466d9c76b037723ce7.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <957b3c14ba05e6658aa767466d9c76b037723ce7.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v649zdNzUv6jsrX6QB-PtS6MS1HAh1Y4xgiptGY+Fvn08w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> All our pinctrl nodes were using a node name convention with a unit-address
> to differentiate the different muxing options. However, since those nodes
> didn't have a reg property, they were generating warnings in DTC.
>
> In order to accomodate for this, convert the old nodes to the syntax we've
> been using for the new SoCs, including removing the letter suffix of the
> node labels to the bank of those pins to make things more readable.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

I only looked at the .dtsi file.

Acked-by: Chen-Yu Tsai <wens@csie.org>
