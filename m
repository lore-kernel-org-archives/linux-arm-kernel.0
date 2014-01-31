From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 15:04:10 -0800
Subject: [PATCH] ARM: keystone: config: fix build warning when
 CONFIG_DMADEVICES is not set
In-Reply-To: <1389278226-23071-1-git-send-email-santosh.shilimkar@ti.com>
References: <1389278226-23071-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140131230410.GB9804@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 09:37:06AM -0500, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Drop automatic selection of TI_EDMA from Keystone Kconfig file,
> as it produces build warning in case if CONFIG_DMADEVICES is not set:
> 
> warning: (ARCH_KEYSTONE) selects TI_EDMA which has unmet direct dependencies (DMADEVICES && (ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE))
> 
> Instead enable TI EDMA support from defconfig.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> 
> Kevin, Olof, Arnd,
> 
> Please let me know if you can pick this patch in 3.14 arm-soc
> queue or you prefer a pull request for the same. It applies against
> 'next/soc' cleanly.

Seems like it was missed, I've applied it to fixes now.

-Olof
