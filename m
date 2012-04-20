From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 20 Apr 2012 17:17:43 +0200
Subject: [PATCH v6] i2c: Add device tree support to i2c-pnx.c
In-Reply-To: <1334928849-18079-1-git-send-email-stigge@antcom.de>
References: <1334928849-18079-1-git-send-email-stigge@antcom.de>
Message-ID: <20120420151743.GA12536@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 03:34:09PM +0200, Roland Stigge wrote:
> This patch adds device tree support to the pnx-i2c driver by using platform
> resources for memory region and irq and removing dependency on mach includes.
> 
> The following platforms are affected:
> 
> * PNX
> * LPC31xx (WIP)
> * LPC32xx
> 
> The patch is based on a patch by Jon Smirl, working on lpc31xx integration
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Applied to next \o/

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/f7154605/attachment-0001.sig>
