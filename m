From: shorne@gmail.com (Stafford Horne)
Date: Mon, 20 Mar 2017 23:11:35 +0900
Subject: [PATCH v2] generic syscalls: Wire up statx syscall
In-Reply-To: <20170320123320.GK17263@arm.com>
References: <20170313144521.28127-1-shorne@gmail.com>
 <20170320123320.GK17263@arm.com>
Message-ID: <20170320141135.GA2570@lianli.shorne-pla.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:33:20PM +0000, Will Deacon wrote:
> On Mon, Mar 13, 2017 at 11:45:21PM +0900, Stafford Horne wrote:
> > The new syscall statx is implemented as generic code, so enable it
> > for architectures like openrisc which use the generic syscall table.
> > 
> > Fixes: a528d35e8bfcc ("statx: Add a system call to make enhanced file info available")
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Change in v2:
> >  - Add a few more Cc's to get attention of the right people
> >  - Add a fixes tag for better audit
> > 
> >  include/uapi/asm-generic/unistd.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> As suggested by Arnd, I'll pick this up via arm64 for 4.11. I was on holiday
> last week, so sorry for the delay.

Thanks,  I talked to Masami as well, and he told me that might be the
case.

-Stafford

> Thanks,
> 
> Will
