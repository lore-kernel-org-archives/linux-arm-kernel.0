From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jul 2018 13:10:40 +0100
Subject: [PATCH] arm64: Clear the stack
In-Reply-To: <CAGXu5jLwhdKy6rfSKOeN2hajP5aCnYeT3yMka5ZbJ_o02z=WTA@mail.gmail.com>
References: <20180629190553.7282-1-labbott@redhat.com>
 <CAGXu5jLwhdKy6rfSKOeN2hajP5aCnYeT3yMka5ZbJ_o02z=WTA@mail.gmail.com>
Message-ID: <20180712121040.GB16043@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 05:05:32PM -0700, Kees Cook wrote:
> On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
> >  include/linux/stackleak.h             |  1 +
> > [...]
> > diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> > index e2da99b3a191..00d62b302efb 100644
> > --- a/include/linux/stackleak.h
> > +++ b/include/linux/stackleak.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/task_stack.h>
> >
> > +#include <asm/stacktrace.h>
> >  /*
> >   * Check that the poison value points to the unused hole in the
> >   * virtual memory map for your platform.
> 
> FYI, I squashed this change into my copy of the stackleak v14 series.
> (And I just sent this arm64 patch with the adjustments for it to be
> stand-alone.)

I can't find that -- can you point me to it, please?

Will
