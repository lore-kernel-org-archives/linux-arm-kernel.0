From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:01:30 +0800
Subject: [PATCH 40/77] ARM: dts: sun7i: Remove card detect pull-up
In-Reply-To: <94d897a4a9fc186a716f96c69460a4554e16b132.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <94d897a4a9fc186a716f96c69460a4554e16b132.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66HE7suxHfp1vstB=-CE6FtE4EX-bGP4ZgbWtfFbc_H1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Boards usually have an external pull-up on the card-detect signal, so
> there's no need to add another one.
>
> This also removes a DTC warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
