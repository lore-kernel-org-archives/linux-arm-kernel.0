From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 11:09:29 +0800
Subject: [linux-sunxi] [PATCH 04/10] ARM: sunxi: h3/h5: Add r_i2c I2C
 controller
In-Reply-To: <20170723102749.17323-5-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-5-icenowy@aosc.io>
Message-ID: <CAGb2v64LW+GzzdKHKKEsKg+1DNnhGEUu7f9A6uCz_XKuN6RSCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Allwinner H3/H5 SoCs have an I2C controller at PL GPIO bank.
>
> Add support for it in the device tree.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> [Icenowy: Change to use r_ccu and change pinmux node name]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
