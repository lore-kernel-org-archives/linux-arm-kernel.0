From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2011 00:25:31 -0700
Subject: [PATCH 03/13] ARM: omap1: delete useless interrupt handler
In-Reply-To: <87boza4t5n.fsf@ti.com>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhMf-0000yV-78@rmk-PC.arm.linux.org.uk> <87boza4t5n.fsf@ti.com>
Message-ID: <20110512072531.GD31483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110510 05:46]:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > The OMAP1 clocksource interrupt handler just increments a variable
> > which otherwise isn't used, so this seems to be unnecessary.  Tony
> > Lindgren confirms, so lets remove it.
> >
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap at vger.kernel.org
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Yes, this is left over legacy code from an earlier implementation.
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
