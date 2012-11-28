From: Barry.Song@csr.com (Barry Song)
Date: Wed, 28 Nov 2012 02:37:58 +0000
Subject: [PATCH] ARM: use clockevents_config_and_register() where possible
In-Reply-To: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
References: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E901229845B5@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo at linaro.org]
> Sent: Monday, November 26, 2012 9:34 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Arnd Bergmann; Olof Johansson; Shawn Guo; Nicolas Ferre; Anton
> Vorontsov; Kukjin Kim; Russell King; Sascha Hauer; Jason Cooper; Roland Stigge;
> Eric Miao; Haojian Zhuang; David Brown; Tony Lindgren; Barry Song; Stephen
> Warren; Tony Prisk; Lennert Buytenhek; Wan ZongShun; Viresh Kumar
> Subject: [PATCH] ARM: use clockevents_config_and_register() where possible
> 
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: Lennert Buytenhek <buytenh@wantstofly.org>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> ---

Acked-by: Barry Song <baohua.song@csr.com>


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
