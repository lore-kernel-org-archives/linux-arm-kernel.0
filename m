From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 22:49:17 +0800
Subject: [PATCH v5 07/22] drivers: soc: sunxi: Add support for the C1 SRAM
 region
In-Reply-To: <20180710080114.31469-8-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-8-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v65fgkG0hiSuX_VyD1TBCw7OQLoBBJLpun1GK4yUCnPwNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 4:00 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> This introduces support for the SRAM C1 section, that is controlled by
> the system controller. This SRAM area can be muxed either to the CPU
> or the Video Engine, that needs this area to store various tables (e.g.
> the Huffman VLD decoding tables).
>
> This only supports devices with the same layout as the A10 (which also
> includes the A13, A20, A33 and other SoCs).
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
