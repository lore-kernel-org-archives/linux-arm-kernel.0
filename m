From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 26 Jul 2016 10:30:37 +0200
Subject: [PATCH 8/9] clk: sunxi-ng: Add A31/A31s clocks
In-Reply-To: <1469516671-19377-9-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-9-git-send-email-wens@csie.org>
Message-ID: <20160726103037.5a1571dd124f7c29bb8daa88@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2016 15:04:30 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> +static const struct ccu_mux_fixed_prediv clk_out_predivs[] = {
> +	{ .index = 0, .div = 750, },
> +	{ .index = 3, .div = 4, },
> +	{ .index = 4, .div = 4, },
> +};

No end of table.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
