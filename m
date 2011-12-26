From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Dec 2011 09:58:30 +0800
Subject: [PATCH 1/2 v2] imx: Add save/restore functions for UART control
 regs
In-Reply-To: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
References: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <20111226015829.GI8240@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 09:57:52AM +0100, Dirk Behme wrote:
> Factor out the uart save/restore functionality instead of
> having the same code several times in the driver.
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> CC: Saleem Abdulrasool <compnerd@compnerd.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> CC: linux-serial at vger.kernel.org
> CC: Alan Cox <alan@linux.intel.com>

I queued this for 3.3, and will send a pull-request to Greg.

-- 
Regards,
Shawn
