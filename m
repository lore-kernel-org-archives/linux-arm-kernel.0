From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 30 Sep 2015 16:53:52 +0200 (CEST)
Subject: [PATCH v2 0/7] net: mvneta: Switch to per-CPU irq and make
 rxq_def useful
In-Reply-To: <1443197378-30717-1-git-send-email-gregory.clement@free-electrons.com>
References: <1443197378-30717-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1509301650150.4500@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Sep 2015, Gregory CLEMENT wrote:
> I also reorganized the series, the 3 first patches should go through
> the irq subsystem, whereas the 4 others should go to the network
> subsystem.
> 
> However, there is a runtime dependency between the two parts. Patch 5
> depend on the patch 3 to be able to use the percpu irq.

The first 3 are good to go from my side. To avoid merge window
dependencies, I'll create a branch irq/for-net with these 3 patches
and merge that into irq/core.

So if the network folks want to pick up the rest, they can merge in
that branch as well.

Thanks,

	tglx
