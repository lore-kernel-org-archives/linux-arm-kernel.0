From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Oct 2010 11:42:00 -0700
Subject: [PATCH 6/10] ARM: S5PV210: Add audio clocks as sysclk
In-Reply-To: <1286193468-18510-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286193468-18510-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20101004184159.GG2835@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 08:57:48PM +0900, Seungwhan Youn wrote:
> This patch adds audio clocks(SCLK_AUDIO{0,1,2} and SCLK_AUDIO) to be
> initial as a sysclk on boot-time.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
