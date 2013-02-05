From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Feb 2013 21:53:47 -0800
Subject: [PATCH] ARM: MARCO: fix the build issue due to
 gic-vic-to-irqchip move
In-Reply-To: <1359956496-8997-1-git-send-email-Barry.Song@csr.com>
References: <1359956496-8997-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20130205055347.GA13049@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 01:41:36PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> Fix the issue:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/soc
> head:   6ed05a2aab3763b58922247543d7079106b254dc
> commit: af70fdc947dbe835acc26c6ee9e8e930f38935f8 [4/8] Merge branch 'marco-timer-cleanup-rebase' of
> git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel into next/soc
> config: make ARCH=arm prima2_defconfig
> 
> All error/warnings:
> 
> >> arch/arm/mach-prima2/platsmp.c:20:30: fatal error: asm/hardware/gic.h: No such file or directory
>    compilation terminated.
> --
> >> arch/arm/mach-prima2/common.c:15:30: fatal error: asm/hardware/gic.h: No such file or directory
>    compilation terminated.

Applied, thanks.


-Olof
