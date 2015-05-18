From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 May 2015 14:47:02 +0100
Subject: [PATCH v2 0/2] ARM: move Dual-Timer SP804 driver to
 drivers/clocksource
In-Reply-To: <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20150518134702.GY2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 01:44:42PM +0100, Sudeep Holla wrote:
> Since there are ARM64 platforms(e.g. Juno) with SP804 timers, we need
> to move the driver out of arch/arm so that the code can be shared.
> 
> Changes v1->v2:
> 	- introduces sp804_timer_disable and retained the integrator
> 	  and realview timer initialisation code as suggested by Russell
> 
> v1: https://lkml.org/lkml/2015/4/30/225

This looks fine to me, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
