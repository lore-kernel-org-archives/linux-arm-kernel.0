From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Mar 2014 08:56:11 -0700
Subject: [PATCH 42/75] ARM: l2c: omap2: implement new write_sec method
In-Reply-To: <E1WTYXh-0007Fh-BP@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYXh-0007Fh-BP@rmk-PC.arm.linux.org.uk>
Message-ID: <20140328155611.GB24308@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:21]:
> With the write_sec method, we no longer need to override the default
> L2C disable method, and we no longer need the L2C set_debug method.
> Both of these can be handled via the write_sec method.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
