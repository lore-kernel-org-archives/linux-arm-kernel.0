From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 28 Jul 2014 09:45:40 +0800
Subject: [PATCH 1/5] ARM: imx: Remove references to platform_bus in mxc
 code
In-Reply-To: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140728014538.GH8821@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 03:23:49PM +0100, Pawel Moll wrote:
> The bus devices created to be parents for other peripherals
> were using platform_bus as a parent, not being platform
> devices themselves. Remove the references, making them
> virtual devices instead.
> 
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Acked-by: Shawn Guo <shawn.guo@freescale.com>
