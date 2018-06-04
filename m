From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 4 Jun 2018 09:40:29 +0200
Subject: [PATCH v2 0/9] Rewrite asm-generic/bitops/{atomic,lock}.h and
 use on arm64
In-Reply-To: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180604074029.GN12217@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 05:06:20PM +0100, Will Deacon wrote:
> Hi all,
> 
> This patch series has previously been posted in RFC form here:
> 
>   RFCv1: https://www.spinics.net/lists/arm-kernel/msg634719.html
>   RFCv2: https://www.spinics.net/lists/arm-kernel/msg636875.html
>      v1: https://www.spinics.net/lists/arm-kernel/msg655262.html
> 
> The only change since v1 is that some of the fetch ops are replaced
> by non-value-returning ops for some of the atomic bitops.
> 

Looks good,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

How do you want to route this, through tip or the arm64 tree?
