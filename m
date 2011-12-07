From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Dec 2011 16:21:20 -0800
Subject: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
In-Reply-To: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 (Govindraj R.'s message of "Fri, 11 Nov 2011 15:27:17 +0530")
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <874nxd5j0f.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Converting uart driver to adapt to pm runtime API's.
> Code re-org + cleanup.
> Moving some functionality from serial.c to omap-serial.c

Alan, can you confirm your Ack's are still valid on the drivers/tty
parts of this series?  It has gone through quite a few changes since
your original ack.

Greg, are you ok with this series merging via the OMAP tree since it is
changing arch/arm/mach-omap2/* code as well as the driver, and should go
together.  If so, with your ack (on the drivers/tty/* parts), I'll
handle this series through the OMAP tree.

Thanks,

Kevin
