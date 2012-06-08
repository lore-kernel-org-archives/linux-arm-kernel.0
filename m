From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 08 Jun 2012 10:31:44 +0100
Subject: [PATCH v7 03/12] ARM: SoC: convert VExpress/RealView to SoC
 descriptor
In-Reply-To: <1339085369-26073-4-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
 <1339085369-26073-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339147904.29543.14.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-07 at 17:09 +0100, Marc Zyngier wrote:
> Convert both Realview and VExpress to use the SoC descriptor to
> provide their SMP and CPU hotplug operation.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> arch/arm/mach-vexpress/core.h                  |   10 ++++++++++
>  arch/arm/mach-vexpress/hotplug.c               |    6 +++---
>  arch/arm/mach-vexpress/platsmp.c               |   21 +++++++++++++++++----
>  arch/arm/mach-vexpress/v2m.c                   |   10 ++++++++++
>  arch/arm/plat-versatile/include/plat/platsmp.h |   14 ++++++++++++++
>  arch/arm/plat-versatile/platsmp.c              |    4 ++--
>  15 files changed, 96 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawe?
