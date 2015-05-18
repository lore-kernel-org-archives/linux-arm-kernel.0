From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 18 May 2015 16:34:40 +0200 (CEST)
Subject: [PATCH v2 0/2] ARM: move Dual-Timer SP804 driver to
 drivers/clocksource
In-Reply-To: <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <alpine.DEB.2.11.1505181633470.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 May 2015, Sudeep Holla wrote:

> Since there are ARM64 platforms(e.g. Juno) with SP804 timers, we need
> to move the driver out of arch/arm so that the code can be shared.
> 
> Changes v1->v2:
> 	- introduces sp804_timer_disable and retained the integrator
> 	  and realview timer initialisation code as suggested by Russell
 
Please route this through ARM with my ACK.

Thanks,

	tglx
