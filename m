From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 4 Feb 2013 13:50:02 +0800
Subject: [arm-soc:next/soc 4/8] arch/arm/mach-prima2/platsmp.c:20:30:
 fatal error: asm/hardware/gic.h: No such file or directory
In-Reply-To: <20130130003908.GA12315@quad.lixom.net>
References: <51082342.HQ+h7FMwJqkm7gxO%fengguang.wu@intel.com>
 <20130130002905.GA55457@bee> <20130130003908.GA12315@quad.lixom.net>
Message-ID: <CAGsJ_4w=VbgeynkwHiWkozsGFvQDZR=Grgc67yJ_n_Q7Bc=JTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

2013/1/30 Olof Johansson <olof@lixom.net>
>
> On Wed, Jan 30, 2013 at 08:29:05AM +0800, Xie ChanglongX wrote:
> >
> > Hi Olof,
> >
> > FYI, kernel build failed on
> >
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> > next/soc
> > head:   6ed05a2aab3763b58922247543d7079106b254dc
> > commit: af70fdc947dbe835acc26c6ee9e8e930f38935f8 [4/8] Merge branch
> > 'marco-timer-cleanup-rebase' of
> > git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel into next/soc
> > config: make ARCH=arm prima2_defconfig
>
> Thanks! Yes, this is a known issue as of this morning, I didn't catch it
> before
> I merged in so I asked Barry to follow up with a fix.

done by "[PATCH] ARM: MARCO: fix the build issue due to
gic-vic-to-irqchip move".
i'll not send a pull request for it, would you apply it separately?

>
>
> -Olof

-barry
