From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:35:38 +0800
Subject: [PATCH 21/77] ARM: dts: sun5i: Provide default muxing for
 relevant controllers
In-Reply-To: <5df3fa47088bbebe5c1e16f917b055e37132dba3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <5df3fa47088bbebe5c1e16f917b055e37132dba3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66sq1GOs=g1Gme-i1pN1nKQHiz+YCg_cpRjU9yKkoNWig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The I2C's, MMC0 and MMC1 controllers have only one muxing option in the
> SoC. In such a case, we can just move the muxing into the DTSI, and remove
> it from the DTS.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
