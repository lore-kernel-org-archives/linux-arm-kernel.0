From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 27 Aug 2015 21:01:16 +0200
Subject: [PATCH 00/16] deps: deterministic driver initialization order
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <55DF5E7C.8030806@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.08.2015 um 14:28 schrieb Alexander Holler:

> The final 2 patches are fixes which should end up in mainline, regardless
> if this feature is merged or not.

Just in case your serial or MTD-NAND partitions don't work, the drivers
drivers/tty/serial/8250/8250_core.c and drivers/mtd/ofpart.c need the 
same trivial fix for their initcall level as found in the last two 
patches of my series. I'm not going to post these patches now until I've 
got some feedback for the other stuff.

Regards,

Alexander Holler
