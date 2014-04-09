From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Apr 2014 17:38:49 +0200
Subject: [PATCH 14/15] pinctrl: sunxi: define A31 PL0/PL1 pins
In-Reply-To: <1397051478-4113-15-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-15-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140409153849.GK28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 03:51:17PM +0200, Boris BREZILLON wrote:
> Define PL0/PL1 pins available on the A31 SoC.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/pinctrl/pinctrl-sunxi-pins.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-sunxi-pins.h b/drivers/pinctrl/pinctrl-sunxi-pins.h
> index 3d60669..274cefa 100644
> --- a/drivers/pinctrl/pinctrl-sunxi-pins.h
> +++ b/drivers/pinctrl/pinctrl-sunxi-pins.h
> @@ -2818,6 +2818,14 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "nand1")),	/* CE3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN_PL0,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "p2wi")),		/* SCL */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN_PL1,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "p2wi")),		/* SDA */

If possible, I'd prefer to have this list as exhaustive as
possible.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/10191d42/attachment.sig>
