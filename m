From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 11 Jan 2011 18:10:50 +0100
Subject: [PATCH 1/2] serial: Add auart driver for i.MX23/28
In-Reply-To: <1294758545-9445-2-git-send-email-s.hauer@pengutronix.de>
References: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
	<1294758545-9445-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110111171050.GA522@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 04:09:04PM +0100, Sascha Hauer wrote:
[...]
> +#include <asm/cacheflush.h>
> +#include <mach/mx28.h>

What about MX23 and STMP3xxx?

> +
> +#define MXS_AUART_PORTS 5

MX23 has just 2. We should better adapt to that depending on the type?

Bye,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110111/e2e6b8c3/attachment.sig>
