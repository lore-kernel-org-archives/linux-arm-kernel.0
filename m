From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 10:41:08 -0800
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <1359742975-10421-2-git-send-email-mporter@ti.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
Message-ID: <20130201184107.GM22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <mporter@ti.com> [130201 10:25]:
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx) as well.

I think this should rather go to drivers/dma/?

Tony
