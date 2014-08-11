From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Mon, 11 Aug 2014 13:30:50 +0000
Subject: [PATCH 0/4] irqchip: gic-v2m: Rework GICv2m Initialization
In-Reply-To: <53E87ADA.6040204@arm.com>
References: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
 <53E87ADA.6040204@arm.com>
Message-ID: <02D2024799561B48A732D1A51CB969E836F74ABC@satlexdag05.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

Jason already created a branch irqchip/gic-v2m, which I have created my patch against.  So, what branch do you want me to re-create a patch against for you to review?

Suravee

-----Original Message-----
From: Marc Zyngier [mailto:marc.zyngier at arm.com] 
Sent: Monday, August 11, 2014 3:12 AM
To: Suthikulpanit, Suravee
Cc: Mark Rutland; jason at lakedaemon.net; Pawel Moll; Catalin Marinas; Will Deacon; tglx at linutronix.de; Kasiviswanathan, Harish; linux-arm-kernel at lists.infradead.org; linux-pci at vger.kernel.org; linux-kernel at vger.kernel.org; linux-doc at vger.kernel.org; devicetree at vger.kernel.org
Subject: Re: [PATCH 0/4] irqchip: gic-v2m: Rework GICv2m Initialization

Hi Suravee,

On 09/08/14 00:17, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch set reworks the GICv2m initialization based on Marc Zyngier 
> review comments.
> 
> * Rebase to git://git.infradead.org/users/jcooper/linux.git 
> irqchip/gic-v2m
> 
> Suravee Suthikulpanit (1):
>   irqchip/gic-v2m: Restructure the initalization code for v2m
> 
>  Documentation/devicetree/bindings/arm/gic.txt |  37 +++++++--
>  drivers/irqchip/irq-gic-v2m.c                 | 115 +++++++++-----------------
>  drivers/irqchip/irq-gic.c                     |  30 +++----
>  drivers/irqchip/irq-gic.h                     |  10 +--
>  4 files changed, 91 insertions(+), 101 deletions(-)
> 

While I appreciate that you're trying to reduce the amount of stuff we review, it is actually much easier to look at the patch series as a whole, rather then as a diff against the previous version.

Please squash this into your original series and repost it with a log of what has changed in the cover letter.

Thanks,

	M.
--
Jazz is not dead. It just smells funny...
