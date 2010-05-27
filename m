From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 27 May 2010 23:13:56 +0200
Subject: [PATCH v3] i.MX27: add suspend to RAM support
In-Reply-To: <20100527201600.GF25921@n2100.arm.linux.org.uk>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
	<1274969635-2212-1-git-send-email-eric@eukrea.com>
	<20100527194305.GB25921@n2100.arm.linux.org.uk>
	<4BFED0AC.6000604@eukrea.com>
	<20100527201600.GF25921@n2100.arm.linux.org.uk>
Message-ID: <20100527211356.GB5636@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Eg, we have asm/memory.h, and there is a linux/memory.h, but the two
> are completely unrelated - so the checkpatch warnings about "use
> linux/memory.h rather than asm/memory.h" are rather misleading.

checkpatch can blacklist .h-files for this warning (as it does for irq.h at the
moment). Do you think adding memory.h there is worthwhile? I'd prepare a patch,
then.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100527/86c6e21d/attachment.sig>
