From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Jan 2012 10:33:58 +0100
Subject: [PATCH v4 0/2] mx-sdma: memory barrier fix
In-Reply-To: <1326033862-25351-1-git-send-email-richard.zhao@linaro.org>
References: <1326033862-25351-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120109093358.GN5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 10:44:20PM +0800, Richard Zhao wrote:
> Changes in v4:
>  - convert all _raw_readl/_raw_writel to readl/writel.
> 
> Changes in v3:
>  - use writel instead of explicitly call wmb.
> 
> Changes in v2:
>  - add "let sdma_run_channel call sdma_enable_channel"

Both

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
