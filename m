From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:40:32 +0800
Subject: [PATCH 23/77] ARM: dts: sun6i: Change framebuffer node names to
 avoid warnings
In-Reply-To: <92add4869d5738cf12766e3ca7ee379d3177397b.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <92add4869d5738cf12766e3ca7ee379d3177397b.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v656w-p9gEkqfR0V_YSO+mpr51qR3oRybS3z8bhpwsXiow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The simple-framebuffer nodes have a unit address, but no reg property which
> generates a warning when compiling it with DTC.
>
> Change the simple-framebuffer node names so that there is no warnings on
> this anymore.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
