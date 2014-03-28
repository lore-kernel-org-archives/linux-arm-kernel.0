From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Mar 2014 08:54:43 -0700
Subject: [PATCH 04/75] ARM: l2c: omap2: remove ES1.0 support
In-Reply-To: <E1WTYUR-0004W9-RD@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYUR-0004W9-RD@rmk-PC.arm.linux.org.uk>
Message-ID: <20140328155443.GA24308@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:18]:
> Santosh says:
> > But we should kill all of that since we long back decided to remove
> > ES1.0 related code. The mach-omap code alreasy has removed the ES1.0
> > compatibility so feel free to remove any specific ES1.0
> > related stuff. That silicon is long dead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Makes sense to me to make the handling generic:

Acked-by: Tony Lindgren <tony@atomide.com>
