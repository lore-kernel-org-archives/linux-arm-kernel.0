From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 09:59:48 +0100
Subject: [PATCH 1/3] irqchip: add basic infrastructure
In-Reply-To: <508C9653.8010901@wwwdotorg.org>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <508C9653.8010901@wwwdotorg.org>
Message-ID: <20121028095948.4d062bd1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sat, 27 Oct 2012 20:20:03 -0600, Stephen Warren wrote:
> On 10/27/2012 10:45 AM, Thomas Petazzoni wrote:
> ...
> > So, upon the suggestion of Rob Herring and Arnd Bergmann, this commit
> > introduces a small infrastructure that defines a central
> > irqchip_init() function in drivers/irqchip/irqchip.c, which is meant
> > to be called as the ->init_irq() callback of ARM platforms.
> 
> This patch.
> Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>

Thanks.

> As a minor aside, I only received patch 2/3 in my inbox initially, and
> that made no sense to me without reading this patch too. It would have
> been helpful to have been CC'd on the whole series.

I did Cc: you on patch 2/3 specifically because it was the one
affecting the bcm2835 architecture you're maintaining. But agreed, it
doesn't make much sense to see only this patch 2/3, so I'll Cc you on
the entire series for the next version.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
