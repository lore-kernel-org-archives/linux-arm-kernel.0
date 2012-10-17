From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 17 Oct 2012 18:20:43 +0100
Subject: [RFC PATCH] ARM: SMP: consolidate holding pen
In-Reply-To: <1350487967-2555-1-git-send-email-marc.zyngier@arm.com>
References: <1350487967-2555-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1350494443.1242.76.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-17 at 16:32 +0100, Marc Zyngier wrote:
> As with other bits of the SMP code, platforms have duplicated a lot
> of the RealView implementation. As an effort to slightly reduce
> the clutter, make the plat-versatile version of the holding pen
> a standard part of the SMP framework.
> 
> Platforms can still provide their own, but those who carried an exact
> duplicate of the Realview code are switched to the common implementation.

This bit:

>  arch/arm/mach-vexpress/platsmp.c               |  2 +-

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawel
