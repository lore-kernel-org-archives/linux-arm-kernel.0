From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 25 Jun 2012 22:45:55 +0530
Subject: [PATCH v5 1/7] ARM: davinci, cp_intc: Add irq domain support
In-Reply-To: <1338373143-7467-2-git-send-email-hs@denx.de>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-2-git-send-email-hs@denx.de>
Message-ID: <4FE89CCB.4090609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 5/30/2012 3:48 PM, Heiko Schocher wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
> 
> ---

Applying this patch with two changes:

1) select IRQ_DOMAIN for CP_INTC arch/arm/mach-davinci/Kconfig. Without
this build breaks.

2) Add some commit description. For future, please have some commit
description on all patches.

I boot tested this on AM18x EVM. Also tested that GPIO interrupts are
not broken.

Thanks,
Sekhar
