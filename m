From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 13 Oct 2009 10:56:37 +0300
Subject: [PATCH] ARM: ELF: Add register information of threads to coredump
In-Reply-To: <20091012133854.GA2480@n2100.arm.linux.org.uk>
References: <1255242411-16025-1-git-send-email-dedekind1@gmail.com>
	<20091012133854.GA2480@n2100.arm.linux.org.uk>
Message-ID: <1255420597.32489.5.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-10-12 at 14:38 +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 11, 2009 at 09:26:51AM +0300, Artem Bityutskiy wrote:
> > From: Mika Westerberg <mika.westerberg@iki.fi>
> > 
> > Defines ELF_CORE_COPY_TASK_REGS so that CPU register information
> > of every thread is included in coredump. Without this, only the faulting
> > thread is coredumped.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> > Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> > Cc: Roger Quadros <ext-roger.quadros@nokia.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> 
> Please send to the patch system.

OK, done.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
