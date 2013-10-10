From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 10 Oct 2013 16:04:57 -0700
Subject: [GIT PULL] Second round of Renesas ARM based SoC updates for v3.13
In-Reply-To: <cover.1381293239.git.horms+renesas@verge.net.au> (Simon Horman's
 message of "Wed, 9 Oct 2013 15:49:27 +0900")
References: <cover.1381293239.git.horms+renesas@verge.net.au>
Message-ID: <87siw8n2w6.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Hi Olof, Kevin and Arnd,
>
> please consider this second round of Renesas ARM based SoC updates for v3.13.
>
> This pull-request is based on a merge of the following, each of which
> you have already pulled. The reason for the merge is to eliminate conflicts.
> * renesas-soc-for-v3.13
> * renesas-smp-for-v3.13
> * renesas-fixes4-for-v3.13
>
> The following changes since commit 243b6db0588b1425cb020e764475e8e1c4eb40d9:
>
>   Merge tag 'renesas-fixes4-for-v3.12' into soc2-base (2013-10-08 09:44:08 +0900)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.13
>
> for you to fetch changes up to 687c27b07050c21a62c4c975777c89e698649a6b:
>
>   ARM: shmobile: r8a7791 SMP support (2013-10-08 09:53:02 +0900)
>
> ----------------------------------------------------------------
> Second Round of Renesas ARM based SoC updates for v3.13
>
> * SMP support for r8a7791 SoC
> * r8a7779_init_irq_extpin() for DT for r8a7779 and r8a7778 SoCs
> * Add HPB-DMAC to r8a7779 and r8a7778 SoCs
> * Add r7s72100 SoC
> * Make use of ARCH timer workaround on r8a7791 SoC
> * Add IRQC platform device support to r8a7791 SoC
> * Add I2C clocks and aliases for the DT mode for r8a7790 SoC
> * Add MAC platform device to r8a73a4 SoC

Pulled into next/soc,

Thanks,

Kevin
