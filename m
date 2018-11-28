From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:54:42 +0800
Subject: [PATCH 38/77] ARM: dts: sun7i: Change framebuffer node names to
 avoid warnings
In-Reply-To: <bc7833d43f0e28c57ea3414ffe5692255ac1e7ad.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <bc7833d43f0e28c57ea3414ffe5692255ac1e7ad.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66fP8=8O4BhqtmmuU9MMf0OJugvLoPvb3qM6O6VAEa_oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The simple-framebuffer nodes have a unit address, but no reg property which
> generates a warning when compiling it with DTC.
>
> Change the simple-framebuffer node names so that there is no warnings on
> this anymore.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
