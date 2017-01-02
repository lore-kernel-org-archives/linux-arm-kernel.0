From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 2 Jan 2017 12:53:42 +0300
Subject: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
In-Reply-To: <20161230155634.8692-2-dsafonov@virtuozzo.com>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
 <20161230155634.8692-2-dsafonov@virtuozzo.com>
Message-ID: <20170102095342.GD30735@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 06:56:31PM +0300, Dmitry Safonov wrote:
> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
> TASK_SIZE_MAX since:
> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
> FSBASE/GSBASE upper limits"),
> commit a06db751c321 ("pagemap: check permissions and capabilities at
> open time"),
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mips at linux-mips.org
> Cc: linux-parisc at vger.kernel.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-s390 at vger.kernel.org
> Cc: sparclinux at vger.kernel.org
> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>

I've noticed this too.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
