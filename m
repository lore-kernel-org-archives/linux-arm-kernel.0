From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Mar 2012 09:16:59 +0100
Subject: [PATCH] ARM: include linux/bug.h in insn.c
In-Reply-To: <1333142002-15431-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333142002-15431-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <20120331081659.GA26661@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 11:13:22PM +0200, Joachim Eastwood wrote:
> After commit d82227cf8 building the kernel fails with:
>   arch/arm/kernel/insn.c: In function '__arm_gen_branch_thumb2':
>   arch/arm/kernel/insn.c:13: error: implicit declaration of function 'WARN_ON_ONCE'
>   make[1]: *** [arch/arm/kernel/insn.o] Error 1
>   make: *** [arch/arm/kernel] Error 2
> 
> insn.c uses WARN_ON_ONCE so lets include bug.h.

I already have this in my tree.
