From: sstabellini@kernel.org (Stefano Stabellini)
Date: Fri, 2 Dec 2016 10:56:27 -0800 (PST)
Subject: [PATCH 1/2] arm64: Get rid of asm/opcodes.h
In-Reply-To: <20161202105808.GA16090@e104818-lin.cambridge.arm.com>
References: <1480589074-809-1-git-send-email-marc.zyngier@arm.com>
 <1480589074-809-2-git-send-email-marc.zyngier@arm.com>
 <20161202105808.GA16090@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.10.1612021056220.2781@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Dec 2016, Catalin Marinas wrote:
> On Thu, Dec 01, 2016 at 10:44:33AM +0000, Marc Zyngier wrote:
> > The opcodes.h drags in a lot of definition from the 32bit port, most
> > of which is not required at all. Clean things up a bit by moving
> > the bare minimum of what is required next to the actual users,
> > and drop the include file.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm64/include/asm/opcodes.h     |  5 -----
> >  arch/arm64/include/asm/sysreg.h      | 16 ++++++++++------
> >  arch/arm64/kernel/armv8_deprecated.c |  5 ++++-
> >  arch/arm64/kernel/insn.c             |  1 -
> 
> I applied the first patch. I assume the second one, once it gets into
> its final shape, will be merged via the Xen tree.

Sure
