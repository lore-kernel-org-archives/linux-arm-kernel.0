From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 May 2017 18:02:51 +0200
Subject: [PATCH v3 1/5] clk: sunxi-ng: Add sun4i/sun7i CCU driver
In-Reply-To: <528b9b3895e654b6d3cf95187433f9fb7b4eb50c.1493235134.git-series.plaes@plaes.org>
References: <cover.908ce010a25e503bb5ad0967759c723219c6ed0d.1493235134.git-series.plaes@plaes.org>
 <528b9b3895e654b6d3cf95187433f9fb7b4eb50c.1493235134.git-series.plaes@plaes.org>
Message-ID: <20170501160251.rv5uqlq37hfc3ex7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

Almost good, thanks!

On Wed, Apr 26, 2017 at 10:32:21PM +0300, Priit Laes wrote:
> +/* TODO: GPS CLK 0x0d0 */

You should still create a define in the header for this one.

> +/* Following only exist on sun7i-a20 */
> +#define CLK_MBUS		165
> +#define CLK_HDMI1_SLOW		166
> +#define CLK_HDMI1		167
> +#define CLK_OUT_A		168
> +#define CLK_OUT_B		169

Wouldn't it be better to simply create a new A20-only header that
would include the A10's and add the A20 specific clocks on top?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170501/f4c3ee78/attachment.sig>
