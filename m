From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 4 Apr 2011 14:40:32 +0200
Subject: [PATCH v2] ARM: mx5/mx53_smd: Add esdhc support
In-Reply-To: <1301920375-31761-1-git-send-email-fabio.estevam@freescale.com>
References: <1301920375-31761-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110404124032.GA20421@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 09:32:55AM -0300, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Do not use CD and WP detecion via GPIO as it is not working for MX53 yet.

WP, too? I thought Richard had only issues with CD?

Otherwise:

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110404/47f47efd/attachment.sig>
