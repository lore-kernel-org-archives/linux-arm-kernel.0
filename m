From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 21:10:23 +0800
Subject: [PATCH 67/77] ARM: dts: sun8i: BPI-M2M: Remove i2c nodes
In-Reply-To: <37f420d9fd609bba74fbcfbf932745a2746caf80.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <37f420d9fd609bba74fbcfbf932745a2746caf80.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66zVWuuL1g6uyHHVBY8s3diZ-BTB4DTxxJXsCJ4UHwB8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The i2c nodes were pre-populated to ease the use of overlays. However, now
> that we provide default muxing options for those nodes, the one in the DTS
> don't provide any content at all.
>
> Remove them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
