From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 10:53:40 +0800
Subject: [PATCH 03/77] ARM: dts: sun5i: Change framebuffer node names to
 avoid warnings
In-Reply-To: <de87f16f4ed19e130aa451c82f8665e6cb484305.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <de87f16f4ed19e130aa451c82f8665e6cb484305.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64m184MrkCarV5tFjkCCErFR6J284PRp1Z6FtKQobp9mA@mail.gmail.com>
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
