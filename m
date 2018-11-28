From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:46:20 +0800
Subject: [PATCH 29/77] ARM: dts: sun6i: Remove card detect pull-up
In-Reply-To: <ad634fe042cbab93dd8bbad1ed868a96e3cb75b4.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <ad634fe042cbab93dd8bbad1ed868a96e3cb75b4.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64cd6B1D3=JkZ9cCGHsrycRTVQZ5Ln_sWhs9518-DPStg@mail.gmail.com>
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
