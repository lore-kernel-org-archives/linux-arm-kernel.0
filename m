From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Nov 2010 09:47:15 -0700
Subject: [PATCH 2/2] arm: omap1: remove unused variables
In-Reply-To: <1287473455-25773-3-git-send-email-balbi@ti.com>
References: <1287473455-25773-1-git-send-email-balbi@ti.com>
	<1287473455-25773-3-git-send-email-balbi@ti.com>
Message-ID: <20101105164715.GM9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [101019 00:22]:
> Get rid of the following warnings:
> 
> arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_resume':
> arch/arm/mach-omap1/pm_bus.c:51: warning: unused variable 'ret'
> arch/arm/mach-omap1/mailbox.c: In function 'omap1_mbox_probe':
> arch/arm/mach-omap1/mailbox.c:148: warning: unused variable 'i'

Assuming Hiroshi will queue up this one.

Tony
