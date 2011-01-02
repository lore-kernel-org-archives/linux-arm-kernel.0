From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Jan 2011 14:05:18 +0000
Subject: [PATCH 1/4] ARM: Kconfig: Add audio support dependency
In-Reply-To: <1293172569-21465-1-git-send-email-sw.youn@samsung.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
	<1293172569-21465-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20110102140517.GJ4935@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 03:36:09PM +0900, Seungwhan Youn wrote:

> This patch adds Samsung ASoC audio support dependency for Samsung SoCs.

> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

> +	select ASOC_SAMSUNG if SND_SOC

Hrm, if we're going to do this we probably ought to be doing it for all
architectures.  It's a good idea, we don't tend to have multiple
possible architectures supported for a given architecture.  Since the
second patch didn't apply I'll leave this one too, and patches 3 and 4,
though they all look good.
