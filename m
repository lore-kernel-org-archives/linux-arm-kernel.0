From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 14 Oct 2013 13:55:06 -0700
Subject: [GIT PULL] Second Round of Renesas ARM-based SoC DT updates for
 v3.13
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au> (Simon Horman's
 message of "Wed, 9 Oct 2013 15:50:12 +0900")
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <878uxv609h.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Hi Olof, Kevin and Arnd,
>
> please consider this second round of Renesas ARM-based SoC DT updates for v3.13.
>
> This pull request is based on a merge of renesas-soc-for-v3.13
> into renesas-dt-for-v3.13, both of which you have previously pulled.
> The reason for the merge is to eliminate conflicts.
>
>
> The following changes since commit 50128df2c0164a3510da2af9d2dfed2da3987bd3:
>
>   Merge tag 'renesas-soc-for-v3.13' into dt2-base (2013-10-08 09:24:24 +0900)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.13
>
> for you to fetch changes up to 73c79afa61cdee2553461ee714bb4716372bdd55:
>
>   ARM: shmobile: bockw: fixup ether node naming (2013-10-08 10:37:49 +0900)
>
> ----------------------------------------------------------------
> Second Round of Renesas ARM-based SoC DT updates for v3.13
>
> * Correct SMSC ethernet IRQ number on marzen board
> * Add SMSC ethernet node to bockw board
> * Add SDHI, MMCIF and PWM backlight  nodes to armadillo800eva-reference board
> * Add irqpin default status to r8a7779 SoC
> * Add irqpin node to r8a7778 SoC
> * Add SMP, Arch timer and IRQC nodes to r8a7791 SoC
> * Add DMAC node to r8a73a4 SoC
> * Add I2C nodes to r8a7790 SoC
> * Only enable used I2C interfaces in DT on all Renesas boards

Pulled into next/dt.

Thanks,

Kevin
