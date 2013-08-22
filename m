From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 10:23:11 -0700
Subject: [GIT PULL] ux500 core changes for v3.12
In-Reply-To: <CACRpkdbRaV9_oCNKXh2O2JR6pyvz6+5c4=pxYCFhT6-KzbqyMg@mail.gmail.com>
 (Linus Walleij's message of "Mon, 19 Aug 2013 22:54:35 +0200")
References: <CACRpkdbRaV9_oCNKXh2O2JR6pyvz6+5c4=pxYCFhT6-KzbqyMg@mail.gmail.com>
Message-ID: <87txihskqo.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Hi ARM SoC folks,
>
> here are some smallish ux500 core changes for the v3.12
> cycle. Basically just three random patches. The big thing is
> that we can now restart the ux500 with software.
>
> Please pull these in!
>
> Yours,
> Linus Walleij
>
> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
>
>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-core-for-arm-soc
>
> for you to fetch changes up to 0a429fd15ecb05d7d5fa8eb4adaff69c7a00984b:
>
>   ARM: ux500: set coherent_dma_mask for dma40 (2013-08-19 22:49:25 +0200)
>
> ----------------------------------------------------------------
> Core ux500 changes for v3.12:
> - Add support for restart using the PRCMU
> - Move secondary startup out of INIT section
> - set coherent_dma_mask for DMA40

Pulled into next/soc,

Kevin
