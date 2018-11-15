From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Nov 2018 23:53:21 +0800
Subject: [PATCH 04/15] soc: sunxi: sram: Enable EMAC clock access for H3
 variant
In-Reply-To: <20181115145013.3378-5-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-5-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v67QgaeAMPrPagHnn9+gw2hsY7z=pA4bgOg=wSbEnG86Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Just like the A64 and H5, the H3 SoC uses the system control block
> to enable the EMAC clock.
>
> Add a variant structure definition for the H3 and use it over the A10
> one. This will allow using the H3-specific binding for the syscon node
> attached to the EMAC instead of the generic syscon binding.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
