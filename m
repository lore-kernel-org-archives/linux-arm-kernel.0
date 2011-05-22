From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 May 2011 06:45:12 +0800
Subject: [PATCH] cleanup regulator supply definitions in mach-omap2 to
	use REGULATOR_SUPPLY
In-Reply-To: <1306101529-22013-1-git-send-email-green@linuxhacker.ru>
References: <1306101529-22013-1-git-send-email-green@linuxhacker.ru>
Message-ID: <20110522224510.GA15858@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 22, 2011 at 05:58:49PM -0400, green at linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> Also drop old style supply.dev assignments common in hsmmc init
> as no longer needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Note that it'd be better to split into two patches as it makes review
easier.
