From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 22:54:30 +0800
Subject: [linux-sunxi] [PATCH v5 10/22] ARM: dts: sun7i-a20: Use
 most-qualified system control compatibles
In-Reply-To: <20180710080114.31469-11-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-11-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v67APUGDu=KM8opavOEKCjorXRyzshdqzZAifPkQzJHNjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> This switches the sun7i-a20 dtsi to use the most qualified compatibles
> for the system-control block (previously named SRAM controller) as well
> as the SRAM blocks. The sun4i-a10 compatibles are kept since these
> hardware blocks are backward-compatible.
>
> The phandle for system control is also updated to reflect the fact that
> the controller described is really about system control rather than SRAM
> control.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

But see discussion about the SRAM mapping compatibles.
