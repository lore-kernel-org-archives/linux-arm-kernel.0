From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Oct 2010 11:39:06 -0700
Subject: [PATCH 5/10] ARM: S5PV210: Add SCLK_SPDIF clock
In-Reply-To: <1286193154-17201-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286193154-17201-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20101004183903.GF2835@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 08:52:34PM +0900, Seungwhan Youn wrote:
> This patch add SCLK_SPDIF clock to support source clock of S/PDIF
> on S5PV210.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but this looks like an example of where the get and set rate operations
could readily be shared as mentioned in reply to the previous patch.
