From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 Jun 2015 17:13:06 +0100
Subject: [PATCH v2] arm:arm64/hw_breakpoint.c: Remove unnecessary header
In-Reply-To: <20150611152942.GC29425@arm.com>
References: <"000a01d0a433$033bc340$09b349c0$@s"@samsung.com>
 <20150611152942.GC29425@arm.com>
Message-ID: <20150611161306.GD29305@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 04:29:43PM +0100, Will Deacon wrote:
> On Thu, Jun 11, 2015 at 11:39:58AM +0100, Maninder Singh wrote:
> > Header <asm/kdebug.h> is not needed in hw_breakpoint.c 
> > for arm as well as arm64.
> > Removing the same.
> > 
> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> > Reviewed-by: Vaneet Narang <v.narang@samsung.com>
> > ---
> >  arch/arm/kernel/hw_breakpoint.c   |    1 -
> >  arch/arm64/kernel/hw_breakpoint.c |    1 -
> >  2 files changed, 0 insertions(+), 2 deletions(-)
> 
> Sorry for the bother, but can you send this as two separate patches please?
> They'll need to go via two different trees to get into mainline.

Or just send it to kernel-janitors at vger.kernel.org.

-- 
Catalin
