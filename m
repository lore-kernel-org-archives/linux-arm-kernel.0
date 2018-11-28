From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:43:50 +0800
Subject: [PATCH 71/77] ARM: dts: sun8i: v3s: Provide default muxing for
 relevant controllers
In-Reply-To: <6c20c272b6fc4082f02edeb86ef99841031d225a.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <6c20c272b6fc4082f02edeb86ef99841031d225a.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66bwtDnmTZohgrZRE1+O+4WX4vBrug-2OsedeqxqzWSJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The MMC0 controllers have only one muxing option in the SoC. In such a
> case, we can just move the muxing into the DTSI, and remove it from
> the DTS.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
