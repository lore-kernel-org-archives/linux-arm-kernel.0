From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 18:05:04 -0800
Subject: [PATCH] omap1: pm_bus: Fix compilation warning.
In-Reply-To: <87lj41jk8p.fsf@deeprootsystems.com>
References: <1291641828-19909-1-git-send-email-marek.belisko@open-nandra.com>
	<87lj41jk8p.fsf@deeprootsystems.com>
Message-ID: <20101218020504.GM5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101207 14:13]:
> Marek Belisko <marek.belisko@open-nandra.com> writes:
> 
> > Fix following compilation warning:
> > arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_resume':
> > arch/arm/mach-omap1/pm_bus.c:51: warning: unused variable 'ret'
> >
> > Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Taking these except for the mailbox one which is already fixed.

Tony
