From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:37:51 +0800
Subject: [PATCH 60/77] ARM: dts: sun8i: a23/a33: Change LRADC node names
 to avoid warnings
In-Reply-To: <77b7fe2fc4bcee6d7156171421cd6e1dc56a3fe8.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <77b7fe2fc4bcee6d7156171421cd6e1dc56a3fe8.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66mjRZ2mJmjTdqHs4yfjL=2yRn9mrNLBCK2-aDJ-grOQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> One of the usage of the LRADC is to implement buttons. The bindings define
> that we should have one subnode per button, with their associated voltage
> as a property.
>
> However, there was no reg property but we still used the voltage associated
> to the button as the unit-address, which eventually generated warnings in
> DTC.
>
> Rename the node names to avoid those warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
