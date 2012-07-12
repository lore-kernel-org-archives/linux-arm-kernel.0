From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 15:04:34 +0800
Subject: [PATCH] ARM: imx6q: ensure ANATOP controller is available
In-Reply-To: <1342021955-9556-1-git-send-email-otavio@ossystems.com.br>
References: <1342021955-9556-1-git-send-email-otavio@ossystems.com.br>
Message-ID: <20120712070432.GJ6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 12:52:35PM -0300, Otavio Salvador wrote:
> During imx6q initialization the usb charger detector is disabled but
> for it, ANATOP controller symbols need to be available.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> Cc: Richard Zhao <richard.zhao@freescale.com>

Applied, thanks.

Regards,
Shawn
