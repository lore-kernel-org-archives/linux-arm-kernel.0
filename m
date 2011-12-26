From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Dec 2011 09:53:23 +0800
Subject: [PATCH v5] tty: serial: imx: Allow UART to be a source for wakeup
In-Reply-To: <1323746628-25163-1-git-send-email-festevam@gmail.com>
References: <1323434541-27689-1-git-send-email-festevam@gmail.com>
 <1323746628-25163-1-git-send-email-festevam@gmail.com>
Message-ID: <20111226015322.GF8240@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 01:23:48AM -0200, Fabio Estevam wrote:
> Allow UART to be a source for wakeup from low power mode.
> 
> Tested on a MX27PDK by doing:
> 
> echo enabled > /sys/devices/platform/imx21-uart.0/tty/ttymxc0/power/wakeup
> 
> echo mem > /sys/power/state
> 
> and then pressing a key in the console will wakeup the sytem.
> 
> Suggested-by: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---

I queued this for 3.3, and will send a pull-request to Greg.

-- 
Regards,
Shawn
