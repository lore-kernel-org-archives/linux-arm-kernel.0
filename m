From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 22:56:23 +0800
Subject: [PATCH v5 11/22] ARM: sun5i: Add support for the C1 SRAM region
 with the SRAM controller
In-Reply-To: <20180710080114.31469-12-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-12-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v65swXpLwAo3M9X=MJeVmUrjT=FPFZxp=eCzMrfopqHKjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> This adds support for the C1 SRAM region (to be used with the SRAM
> controller driver) for sun5i-based platforms. The region is shared
> between the Video Engine and the CPU.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

But again, see discussion about SRAM compatibles.
