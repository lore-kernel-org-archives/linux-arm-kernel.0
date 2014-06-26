From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Jun 2014 07:43:29 +0200
Subject: [PATCH v3 3/3] ARM: i.MX25 clk: Use of_clk_init() for DT case
In-Reply-To: <1403700096-13014-3-git-send-email-denis@eukrea.com>
References: <1403700096-13014-1-git-send-email-denis@eukrea.com>
 <1403700096-13014-3-git-send-email-denis@eukrea.com>
Message-ID: <20140626054329.GT15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 02:41:36PM +0200, Denis Carikli wrote:
> Replace .init_time() hook with of_clk_init() for DT targets.
> 
> Based on:
>   d4347ee ARM: i.MX27 clk: Use of_clk_init() for DT case
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Looks good now.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
