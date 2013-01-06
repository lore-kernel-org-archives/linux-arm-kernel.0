From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 6 Jan 2013 12:37:54 -0500
Subject: [PATCH] GPIO: MVEBU: Fix so only built when CONFIG_OF_IRQ
In-Reply-To: <1354463099-6121-1-git-send-email-andrew@lunn.ch>
References: <1354463099-6121-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130106173754.GC5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 02, 2012 at 04:44:59PM +0100, Andrew Lunn wrote:
> This driver only builds when CONFIG_OF_IRQ is enabled. So add this as
> a dependency. Dockstar, and other none DT boards don't build because
> of this, when all other OF boards are disabled.
> 
> Reported-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/gpio/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

I believe this was superceded by:

bc1008c gpio/mvebu-gpio: Make mvebu-gpio depend on OF_CONFIG

by Gregory.

thx,

Jason.
