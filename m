From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 21 Jun 2014 17:23:55 +0800
Subject: [PATCH] ARM: imx: add suspend support for i.mx6sx
In-Reply-To: <1403241654-31605-1-git-send-email-b20788@freescale.com>
References: <1403241654-31605-1-git-send-email-b20788@freescale.com>
Message-ID: <20140621092354.GD18165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 01:20:54PM +0800, Anson Huang wrote:
> Add suspend support for i.MX6SX.
> 
> To enter suspend, echo mem > /sys/power/state.
> To exit suspend, using RTC alarm or enable debug UART wakeup.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
