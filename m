From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 28 May 2017 23:08:02 +0800
Subject: [PATCH v3 04/10] pinctrl: sunxi: drop dedicated A20 driver
In-Reply-To: <20170527102308.1988-5-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-5-icenowy@aosc.io>
Message-ID: <CAGb2v64ycEzmyZBMvvmHosJSpp2hqRo4gc6xKKPhqK96Npq5xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 6:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> As we added A20 support to A10 pinctrl driver, now we can delete the
> dedicated A20 pinctrl driver, which is duplicated code.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - Only remove the A20 driver(A10 driver for A20 is enabled in
>   the previous commit now).
>
>  drivers/pinctrl/sunxi/Kconfig             |    4 -
>  drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c | 1056 -----------------------------

You forgot to remove the Makefile entry. Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
