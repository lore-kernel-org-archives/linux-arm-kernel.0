From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Jun 2012 10:08:10 -0600
Subject: [PATCH] arm: tegra: build powergate unconditionally
In-Reply-To: <1339595767-9140-1-git-send-email-w.sang@pengutronix.de>
References: <1339595767-9140-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <4FD8BAEA.6070906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2012 07:55 AM, Wolfram Sang wrote:
> powergate functions are needed for tegra30 as well (see common.c), so
> build it always. Fixes:
> 
> arch/arm/mach-tegra/built-in.o: In function `tegra30_init_early':
> apbio.c:(.init.text+0x78): undefined reference to `tegra_powergate_init'
> 
> (using "allnoconfig" with tegra30 enabled)
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks, applied.
