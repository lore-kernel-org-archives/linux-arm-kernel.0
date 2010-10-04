From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Oct 2010 11:28:47 -0700
Subject: [PATCH 2/10] ARM: S5PC100: Modify SCLK_AUDIO{0,1,2} clock as
	sysclks
In-Reply-To: <1286192356-17997-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286192356-17997-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20101004182553.GC2835@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 08:39:16PM +0900, Seungwhan Youn wrote:
> This patch modify SCLK_AUDIO{0,1,2} to be initial as sysclks
> on boot-time.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
