From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 May 2013 12:20:33 -0400
Subject: [PATCH] ARM: kirkwood: add i2c-gpio controller for km_kirkwood
In-Reply-To: <1369670126-27284-1-git-send-email-valentin.longchamp@keymile.com>
References: <1369670126-27284-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20130527162033.GJ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 05:55:26PM +0200, Valentin Longchamp wrote:
> This controller is used to access the reset management FPGA of the
> km_kirkwood boards.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> ---
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to mvebu/dt

thx,

Jason.
