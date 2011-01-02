From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Jan 2011 14:01:30 +0000
Subject: [PATCH 2/4] ARM: SAMSUNG: Add SMDK audio configuration
In-Reply-To: <1293172938-23615-1-git-send-email-sw.youn@samsung.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
	<1293172938-23615-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20110102140129.GI4935@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 03:42:18PM +0900, Seungwhan Youn wrote:
> This patch adds SMDK audio select configurations based on platform dependacny.
> This helps more easyly and clearly to make sure about configuration on audio
> drivers support on platform side.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

This doesn't apply against current ASoC; I suspect it needs to be merged
via the ARM tree.
