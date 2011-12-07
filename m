From: alan@linux.intel.com (Alan Cox)
Date: Wed, 7 Dec 2011 00:46:32 +0000
Subject: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
In-Reply-To: <874nxd5j0f.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 <874nxd5j0f.fsf@ti.com>
Message-ID: <20111207004632.15c2a5d4@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Dec 2011 16:21:20 -0800
Kevin Hilman <khilman@ti.com> wrote:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > Converting uart driver to adapt to pm runtime API's.
> > Code re-org + cleanup.
> > Moving some functionality from serial.c to omap-serial.c
> 
> Alan, can you confirm your Ack's are still valid on the drivers/tty
> parts of this series?  It has gone through quite a few changes since
> your original ack.

Yes
