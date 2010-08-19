From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 Aug 2010 10:58:55 +0200
Subject: ARM: LPC32XX: Various minor fixes and updates
In-Reply-To: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
References: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
Message-ID: <20100819085855.GA2747@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Aug 18, 2010 at 04:40:53PM -0700, wellsk40 at gmail.com wrote:
> This patch set updates and fixes some minor LPC32xx issues.
> 
> [PATCH 1/6] ARM: LPC32XX: Fix several clock device ID strings
> [PATCH 2/6] ARM: LPC32XX: Fix naming convention issues with some defines
> [PATCH 3/6] ARM: LPC32xx: Fix gpiolib bit mask macro
> [PATCH 4/6] ARM: LPC32xx: Remove MMC peripheral clock enable/disable code
> [PATCH 5/6] ARM: LPC32XX: Remove clock enable code for AMBA driver
> [PATCH 6/6] ARM: LPC32XX: Add board.h for platform_data structures

This looks confusing for me. Those patches come from your branch
'lpc32xx_up1' but some of them are also contained in
'wells/lpc32xx-arch_up1' which you already posted. So, this looks like a
V2 of the series to me or am I wrong? If so, what has changed and why?

If I might add, the increasing number of branches makes it hard to
decide what is currently needed for a board-support; maybe a
"for-mainline"-branch or something similar with all
"state-of-the-art"-branches merged might help here?

Kind regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100819/cb07aca7/attachment-0001.sig>
