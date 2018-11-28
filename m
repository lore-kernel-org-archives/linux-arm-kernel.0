From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 10:53:08 +0800
Subject: [PATCH 01/77] ARM: dts: sun4i: Fix gpio-keys warning
In-Reply-To: <7176711cb25c70abfcd6807d90b7e8f368618dc9.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <7176711cb25c70abfcd6807d90b7e8f368618dc9.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67GR4bRfhcV929UtCnwfvfoGmry_zeD6kvWMRZYXDCEGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Fix the 'unnecessary #address-cells/#size-cells without "ranges" or child
> "reg" property' DTC warning for the gpio-keys DT node on A10 boards.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
