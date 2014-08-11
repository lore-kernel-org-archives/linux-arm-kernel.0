From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Aug 2014 09:12:10 +0100
Subject: [PATCH 0/4] irqchip: gic-v2m: Rework GICv2m Initialization
In-Reply-To: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <53E87ADA.6040204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suravee,

On 09/08/14 00:17, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch set reworks the GICv2m initialization based on Marc Zyngier
> review comments.
> 
> * Rebase to git://git.infradead.org/users/jcooper/linux.git irqchip/gic-v2m
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

While I appreciate that you're trying to reduce the amount of stuff we
review, it is actually much easier to look at the patch series as a
whole, rather then as a diff against the previous version.

Please squash this into your original series and repost it with a log of
what has changed in the cover letter.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
