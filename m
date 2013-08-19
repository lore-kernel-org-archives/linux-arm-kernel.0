From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 19 Aug 2013 13:11:26 +0530
Subject: [GIT PULL] DaVinci fixes for v3.11
In-Reply-To: <5211C957.4090902@ti.com>
References: <5211C957.4090902@ti.com>
Message-ID: <5211CC26.7050702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing the LAKML address this time.

Thanks,
Sekhar

On 8/19/2013 12:59 PM, Sekhar Nori wrote:
> Hi Kevin, Arnd, Olof,
> 
> Can you please pull this fix for v3.11? The commit has been marked
> for inclusion in -stable kernel too.
> 
> Thanks,
> Sekhar
> 
> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
> 
>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.11
> 
> for you to fetch changes up to de30e316d38b0837fe4c09b43f1b52c8e230c44e:
> 
>   ARM: davinci: nand: specify ecc strength (2013-08-16 15:12:20 +0530)
> 
> ----------------------------------------------------------------
> This pull request includes a patch for
> making NAND flash work on multiple DaVinci
> boards. The NAND probe was failing because
> ecc strength was not specified while using
> hardware ecc algorithm.
> 
> ----------------------------------------------------------------
> Sekhar Nori (1):
>       ARM: davinci: nand: specify ecc strength
> 
>  arch/arm/mach-davinci/board-dm355-leopard.c |    1 +
>  arch/arm/mach-davinci/board-dm644x-evm.c    |    1 +
>  arch/arm/mach-davinci/board-dm646x-evm.c    |    1 +
>  arch/arm/mach-davinci/board-neuros-osd2.c   |    1 +
>  4 files changed, 4 insertions(+)
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
