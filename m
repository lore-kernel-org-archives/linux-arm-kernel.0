From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 May 2016 15:23:12 +0200
Subject: [PATCH v2] asm-generic: Drop renameat syscall from default list
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4EA010A@us01wembx1.internal.synopsys.com>
References: <1461965366-7893-1-git-send-email-james.hogan@imgtec.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4EA010A@us01wembx1.internal.synopsys.com>
Message-ID: <5769874.XvA4zrbPZs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2016 05:13:46 Vineet Gupta wrote:
> On Saturday 30 April 2016 02:59 AM, James Hogan wrote:
> > The newer renameat2 syscall provides all the functionality provided by
> > the renameat syscall and adds flags, so future architectures won't need
> > to include renameat.
> >
> > Therefore drop the renameat syscall from the generic syscall list unless
> > __ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
> > including asm-generic/unistd.h, and adjust all architectures using the
> > generic syscall list to define it so that no in-tree architectures are
> > affected.
> >
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> 
> Acked-by: Vineet Gupta <vgupta@synopsys.com>  # for arch/arc

Applied to the asm-generic, tree, thanks!

	Arnd
