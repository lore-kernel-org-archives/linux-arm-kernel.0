From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 14:26:26 +0100
Subject: [PATCH v2] Introduce minimal irqchip infrastructure
In-Reply-To: <508D31EA.3050307@gmail.com>
References: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <508D31EA.3050307@gmail.com>
Message-ID: <20121028142626.3c1ab345@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sun, 28 Oct 2012 08:23:54 -0500, Rob Herring wrote:

> Other than the 2 minor things I mentioned, this series looks good.
> 
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Thanks, I'll repost a v3 once you confirm the part about "depends on
OF_IRQ".

> Also, I have some follow-on patches to move the GIC and VIC to
> drivers/irqchip. It was much more simple than I expected. I'll post them
> later.

Ah good. Aren't they some remaining non-DT users of the GIC and VIC
drivers?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
