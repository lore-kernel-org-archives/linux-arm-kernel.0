From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 01 Apr 2012 01:21:59 +0400
Subject: [PATCH] ARM: include linux/bug.h in insn.c
In-Reply-To: <1333142002-15431-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333142002-15431-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <4F777577.4020305@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 31-03-2012 1:13, Joachim Eastwood wrote:

> After commit d82227cf8 building the kernel fails with:

    Please also specify that commit summary in parens.

>    arch/arm/kernel/insn.c: In function '__arm_gen_branch_thumb2':
>    arch/arm/kernel/insn.c:13: error: implicit declaration of function 'WARN_ON_ONCE'
>    make[1]: *** [arch/arm/kernel/insn.o] Error 1
>    make: *** [arch/arm/kernel] Error 2

> insn.c uses WARN_ON_ONCE so lets include bug.h.

    Let's.

> Signed-off-by: Joachim Eastwood<joachim.eastwood@jotron.com>

WBR, Sergei
