From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jan 2013 19:47:59 -0800
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <1359651943-21752-4-git-send-email-dinguyen@altera.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
Message-ID: <20130201034759.GD4838@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 31, 2013 at 11:05:42AM -0600, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> mach-socfpga is another platform that needs to use
> v7_invalidate_l1 to bringup additional cores. There was a comment that
> the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Tested-by: Pavel Machek <pavel@denx.de>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>

This should be merged through Russell's tree. Please feed it to his patch
tracker.


-Olof
