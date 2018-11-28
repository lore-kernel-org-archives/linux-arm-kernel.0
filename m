From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 11:04:39 +0800
Subject: [PATCH 05/77] ARM: dts: sun5i: Change clock node names to avoid
 warnings
In-Reply-To: <f46c0b69240d050a52ef2ca4c6c4a73f3f587974.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f46c0b69240d050a52ef2ca4c6c4a73f3f587974.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67DjRA8hf4PnK_Ep9FP-w1LdL9X9e+5Dhtt0-FwCWeThw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our oscillators clock names have a unit address, but no reg property, which
> generates a warning in DTC. Change these names to remove those unit
> addresses.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
