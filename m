From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 16 Jan 2010 22:44:36 +0100
Subject: [PATCH] IMX serial: Check platform data pointer before use
In-Reply-To: <1263677310-14244-1-git-send-email-jekhor@gmail.com>
References: <1263677310-14244-1-git-send-email-jekhor@gmail.com>
Message-ID: <20100116214436.GA16617@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 16, 2010 at 11:28:30PM +0200, Yauhen Kharuzhy wrote:
> pdev->dev.platform_data can be NULL in driver probe function. This is
> should be checked before any use of imxuart_platform_data structure.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100116/7ad51732/attachment.sig>
