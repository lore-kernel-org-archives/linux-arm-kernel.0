From: vapier@gentoo.org (Mike Frysinger)
Date: Mon, 30 May 2011 01:02:21 -0400
Subject: [PATCH 3/4] clk: Add fixed-rate clock
In-Reply-To: <1305876469.327290.592839707336.3.gpush@pororo>
References: <1305876469.327290.592839707336.3.gpush@pororo>
Message-ID: <201105300102.23015.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 20, 2011 03:27:49 Jeremy Kerr wrote:
> --- /dev/null
> +++ b/drivers/clk/clk-fixed.c
> +struct clk_hw_ops clk_fixed_ops = {
> +	.recalc_rate = clk_fixed_recalc_rate,
> +};
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> +extern struct clk_hw_ops clk_fixed_ops;

should be const
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110530/6c35116f/attachment.sig>
