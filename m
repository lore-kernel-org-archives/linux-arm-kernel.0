From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Mon, 08 Jul 2013 13:39:21 +0800
Subject: v3.10 - big endian core support
In-Reply-To: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <51DA5089.5080109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2013 07:03 PM, Ben Dooks wrote:
> The latest big-endian changes, now on:
>
> 	git://git.baserock.org/delta/linux baserock/311/be/core
>
> This has a minor fix from the last version where a rebase missed a change
> in the smp_scu code.
>
Hello Ben,

Thanks for you patches at first. I can boot BE kernel on vexpress a15 tc2
board with LPAE disabled.

However if enable LPAE, kernel seems hang after turn on mmu on since
printascii can't output any character in __mmap_switched.
Did you happen to try BE kernel with LPAE enabled before? or am I missed
something?

Thanks,
Xiao

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
