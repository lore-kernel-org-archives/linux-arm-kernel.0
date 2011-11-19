From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Nov 2011 19:03:38 +0000
Subject: [PATCH v2] fix compilation breakage in entry-armv.S
In-Reply-To: <20111118152321.GA30405@localhost.localdomain>
References: <Pine.LNX.4.64.1111081232140.10851@axis700.grange>
 <20111108114050.GC12913@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1111081258240.10851@axis700.grange>
 <20111111151515.GA3099@localhost.localdomain>
 <Pine.LNX.4.64.1111161602510.3881@axis700.grange>
 <20111118152321.GA30405@localhost.localdomain>
Message-ID: <20111119190338.GL9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 03:23:22PM +0000, Dave Martin wrote:
> On Wed, Nov 16, 2011 at 04:05:04PM +0100, Guennadi Liakhovetski wrote:
> > Fix compilation failure, when Thumb support is not enabled:
> > 
> > arch/arm/kernel/entry-armv.S: Assembler messages:
> > arch/arm/kernel/entry-armv.S:501: Error: backward ref to unknown label "2:"
> > arch/arm/kernel/entry-armv.S:502: Error: backward ref to unknown label "3:"
> > make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> That looks fine to me.
> 
> If Russell is OK with this, please send the patch to his patch system
> so we can get this merged.
> 
> Reviewed-by: Dave Martin <dave.martin@linaro.org>

Yes, looks fine to me too.
