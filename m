From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 8 Dec 2011 10:55:08 +0100
Subject: [PATCH V2 1/2] ARM: mx51/53: correct misuse of _clk_max_enable
 and _clk_max_disable
In-Reply-To: <1323307714-21290-2-git-send-email-richard.zhao@linaro.org>
References: <1323307714-21290-1-git-send-email-richard.zhao@linaro.org>
 <1323307714-21290-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111208095508.GW27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 09:28:33AM +0800, Richard Zhao wrote:
> _clk_max_enable and _clk_max_disable should only be used by ahb_max_clk,
> rather not unrelated clocks.

Since you based this onto arm-soc/for-net I assume applying it for
next is ok for you?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
