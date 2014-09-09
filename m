From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 9 Sep 2014 11:24:11 +0200
Subject: [PATCH 0/5] irqchip: atmel-aic: add RTT irq fixup
In-Reply-To: <1409735271-15353-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409735271-15353-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140909092411.GH14623@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2014 at 11:07:46 +0200, Boris Brezillon wrote :
> Hello,
> 
> This patch series add a new fixup function for the RTT (Real Time Timer)
> block and make use of it on SoCs integrating at least one RTT to prevent
> spurious interrupts on the first interrupt line.
> 
> This fixup function was previously implemented in
> arch/arm/mach-at91/sysirq_mask.c, but is now moved to the AIC driver so
> that we can remove SoC specific hooks in arch/arm/mach-at91/ when booting
> a DT kernel.
> 
> This series also reworks the naming convention of the SoC specific fixup
> functions and add an entry for the at91rm9200.
> 
> The series depends on the acceptation of the RTT DT bindings proposed here
> [1].
> 

Whole series is:

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
