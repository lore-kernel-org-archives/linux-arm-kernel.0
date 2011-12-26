From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Dec 2011 09:59:25 +0800
Subject: [PATCH 2/2 v3] imx: add polled io uart methods
In-Reply-To: <1324544273-9820-2-git-send-email-dirk.behme@gmail.com>
References: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
 <1324544273-9820-2-git-send-email-dirk.behme@gmail.com>
Message-ID: <20111226015924.GJ8240@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 09:57:53AM +0100, Dirk Behme wrote:
> From: Saleem Abdulrasool <compnerd@compnerd.org>
> 
> These methods are invoked if the iMX uart is used in conjuction with kgdb during
> early boot.  In order to access the UART without the interrupts, the kernel uses
> the basic polling methods for IO with the device.  With these methods
> implemented, it is now possible to enable kgdb during early boot over serial.
> 
> Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> CC: linux-serial at vger.kernel.org
> CC: Alan Cox <alan@linux.intel.com>

I queued this for 3.3, and will send a pull-request to Greg.

-- 
Regards,
Shawn
