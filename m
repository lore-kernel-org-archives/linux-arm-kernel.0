From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 Jan 2012 16:59:21 +0100
Subject: [PATCH] Correct bad gpio naming
In-Reply-To: <4F1C4E25.6070801@antcom.de>
References: <4F1C4E25.6070801@antcom.de>
Message-ID: <20120124155921.GH2609@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 06:57:57PM +0100, Roland Stigge wrote:
> One of the GPIO names in drivers/gpio/gpio-lpc32xx.c
> was bad. Renaming gpi000 -> gpio00
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Since you are modifying LPC32xx :) Which kernel version do you run? I
was trying to get a board up with 3.0 (not booting) and 3.3-rc1 (build
breakage). I even thought about removing that mach, since vital parts
seem to be missing (Net, NAND) or broken. So, I am interested if there
are still users.

CCing Kevin Wells, too: Any plans from NXP?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/01f81aa4/attachment.sig>
