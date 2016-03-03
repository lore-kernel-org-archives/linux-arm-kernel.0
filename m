From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 3 Mar 2016 17:56:08 +0100
Subject: [PATCH 02/17] irqchip: Add PLX Technology RPS IRQ Controller
In-Reply-To: <000201d17562$5f6f0090$1e4d01b0$@gmail.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-3-git-send-email-narmstrong@baylibre.com>
 <000201d17562$5f6f0090$1e4d01b0$@gmail.com>
Message-ID: <56D86CA8.6030301@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 04:32 PM, Ma Haijun wrote:
> Hi Neil,
> 
> Glad to see the mainline efforts of this SoC family.
> 
> Previously, I did not really understand what this "RPS" stood for.
> After some digging(1)., now I believe it means ARM's Reference Peripheral
> Specification
> though the spec itself seems not publicly available, the peripheral specs
> are accessible.
> The interrupt controller is an AMBA Interrupt Controller(2) and the timers
> are
> AMBA Timer(3). Besides, ARM Dual-Timer Module (SP804)(4) looks like an
> extended version
> of the AMBA timer
> 
> 1)
> http://infocenter.arm.com/help/topic/com.arm.doc.dai0030a/DAI0030A_sw_int_ap
> psnote.pdf
> 2) http://infocenter.arm.com/help/topic/com.arm.doc.ddi0047d/DDI0047.pdf
> 3) http://infocenter.arm.com/help/topic/com.arm.doc.ddi0049c/AMBA_Timer.pdf
> 4) http://infocenter.arm.com/help/topic/com.arm.doc.ddi0271d/DDI0271.pdf
> 
> Regards,
> Haijun

Hi Haijun,

Thanks for the tips !

Indeed the timer looks like the timer-sp804 actually upstream, I'll try this driver before posting a v2.

Concerning the IRQ controller, I did not find any similar drivers.

Marc, Arnd, should I create a specific "arm RPS irq controller" instead ?

Neil
