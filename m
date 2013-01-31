From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jan 2013 11:47:04 +0000
Subject: [PATCH v2 0/4] Preparatory GIC patches for arm64 support
In-Reply-To: <20130131103044.GB12877@arm.com>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
 <20130131103044.GB12877@arm.com>
Message-ID: <20130131114703.GX23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 10:30:44AM +0000, Catalin Marinas wrote:
> Olof, Arnd,
> 
> On Tue, Jan 29, 2013 at 04:18:35PM +0000, Catalin Marinas wrote:
> > That's the second version of the GIC clean-up patches to support arm64.
> > The only change from v1 is that the second patch (chained_irq.h) also
> > covers drivers/gpio and drivers/pinctrl (#include change).
> 
> Are you ok to merge this series via the arm-soc tree for 3.9-rc1? There
> are no complaints so far (only acks ;). This would allow me to push GIC
> support for arm64.

So I don't exist anymore to you?

Catalin, it's already been suggested to you that this series is more
core ARM stuff than SoC stuff, and it's also been suggested that you
merge this through my tree.

No, I guess this figures after all your excessively negative replies
on all of my comments during the review of ARM64.
