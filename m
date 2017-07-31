From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 31 Jul 2017 15:33:15 +0800
Subject: [linux-sunxi] [PATCH] pinctrl: sunxi: rename R_PIO i2c pin
 function name
In-Reply-To: <20170730053618.44781-1-icenowy@aosc.io>
References: <20170730053618.44781-1-icenowy@aosc.io>
Message-ID: <CAGb2v64M+FqOeXMOyGQmUiZGw2K9+oRW8ADy=aeUAXVUn0BfQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 30, 2017 at 1:36 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The I2C pin functions in R_PIO used to be named "s_twi".
>
> As we usually use the name "i2c" instead of "twi" in the mainline
> kernel, change these names to "s_i2c" for consistency.
>
> The "s_twi" functions are not yet referenced by any device trees in
> mainline kernel so I think it's safe to change the name.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
