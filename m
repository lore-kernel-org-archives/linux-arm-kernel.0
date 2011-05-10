From: khilman@ti.com (Kevin Hilman)
Date: Tue, 10 May 2011 14:49:40 +0200
Subject: [PATCH 03/13] ARM: omap1: delete useless interrupt handler
In-Reply-To: <E1QJhMf-0000yV-78@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Tue, 10 May 2011 08:28:17 +0100")
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhMf-0000yV-78@rmk-PC.arm.linux.org.uk>
Message-ID: <87boza4t5n.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> The OMAP1 clocksource interrupt handler just increments a variable
> which otherwise isn't used, so this seems to be unnecessary.  Tony
> Lindgren confirms, so lets remove it.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Yes, this is left over legacy code from an earlier implementation.

Acked-by: Kevin Hilman <khilman@ti.com>
