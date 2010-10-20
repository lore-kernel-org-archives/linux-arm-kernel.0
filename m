From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 20 Oct 2010 13:30:50 +0200
Subject: [PATCH 2/2] babbage: esdhc device registration
In-Reply-To: <1287566647-1322-1-git-send-email-shawn.gsc@gmail.com>
References: <1287564807-1645-1-git-send-email-shawn.gsc@gmail.com>
	<1287566647-1322-1-git-send-email-shawn.gsc@gmail.com>
Message-ID: <20101020113050.GC10261@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 05:24:07PM +0800, Shawn Guo wrote:
> This patch is based on Eric B?nard's bits below to add esdhc
> device registration for babbage board.
> 
>  - cpuimx51: update board support
>  - clock-mx51: factorize clk_set_parent and clk_get_rate
>  - imx-esdhc: update devices registration
> 
> Signed-off-by: Shawn Guo <shawn.gsc@gmail.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101020/10db5b55/attachment.sig>
