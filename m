From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 May 2011 16:01:32 +0100
Subject: [PATCH 15/13] clocksource: ARM sp804: obtain sp804 timer rate
	via	clks
In-Reply-To: <20110512135141.GC6098@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<20110512135141.GC6098@n2100.arm.linux.org.uk>
Message-ID: <1305298892.31204.117.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-12 at 14:51 +0100, Russell King - ARM Linux wrote:
> This allows platforms to specify the rate of the SP804 clocksource via
> the clk subsystem.  While ARM boards clock these at 1MHz, BCMRing also
> has SP804 timers but are clocked at different rates.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
