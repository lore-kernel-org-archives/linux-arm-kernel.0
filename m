From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 10 Oct 2010 21:44:05 +0200
Subject: [PATCH] arch: arm/imx: fix memory init in imx_dma_request()
In-Reply-To: <1286731703-17775-1-git-send-email-segooon@gmail.com>
References: <1286731703-17775-1-git-send-email-segooon@gmail.com>
Message-ID: <20101010194405.GS29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 10, 2010 at 09:28:23PM +0400, Vasiliy Kulikov wrote:
> imx_dma_request() didn't fill struct pointed by imxdma with zeroes
> as it passed sizeof(pointer), not sizeof(struct) to memset().
> 
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
Acked-and-tested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
