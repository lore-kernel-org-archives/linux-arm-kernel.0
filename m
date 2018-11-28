From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:40:48 +0800
Subject: [PATCH 24/77] ARM: dts: sun6i: Change clock node names to avoid
 warnings
In-Reply-To: <f38aee5e3754b101f9cf776ab42a880e0d57ffbf.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f38aee5e3754b101f9cf776ab42a880e0d57ffbf.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67CmqbwtVkf9jKdd5+dj8d8w7O9eS5fUfa0BGjVYnBCtQ@mail.gmail.com>
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
