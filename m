From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 May 2011 11:56:33 +0100
Subject: [PATCH 17/19] clockevents: ARM sp804: obtain sp804 timer rate
	via clks
In-Reply-To: <E1QM1dU-0003EL-9p@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1dU-0003EL-9p@rmk-PC.arm.linux.org.uk>
Message-ID: <1306148193.7196.4.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-16 at 18:31 +0100, Russell King - ARM Linux wrote:
> This allows platforms to specify the rate of the SP804 clockevent via
> the clk subsystem.  While ARM boards clock these at 1MHz, BCMRing also
> has SP804 timers but are clocked at different rates.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

After you fixed Rob's comments:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
