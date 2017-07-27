From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jul 2017 12:51:11 +0200
Subject: [GIT PULL] omap fixes for v4.13 merge window
In-Reply-To: <-2912443834608911586@unknownmsgid>
References: <-2912443834608911586@unknownmsgid>
Message-ID: <CAK8P3a3hYEAN_hm9vc9Ae40WZPVzhg+13+5utfaSWch+u2VB4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 6, 2017 at 11:08 AM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit 1df5eaa6bced2d8a9de305d4a5f587adf57ddf35:
>
>   ARM: OMAP4: hwmod_data: add SHAM crypto accelerator (2017-06-14 00:53:51 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/fixes-merge-window
>
> for you to fetch changes up to ff570a01b1bd15cf8a87c9ea774fc9c52ea07f15:
>
>   ARM: dts: dra71-evm: mdio: Fix impedance values (2017-07-05 00:54:52 -0700)
>
> ----------------------------------------------------------------
> Few fixes for omaps for issues found recently:
>
> - Fix disable_irq related shared IRQ warnings for omap3 PRM
>
> - Fix omap4 legacy code regression that accidentally removed code that
>   we still need for PRM interrupts
>
> - Fix dm8168-evm NAND pins and MMC write protect pin direction
>
> - Fix dra71-evm mdio impedance values

Pulled into fixes now, thanks!

        Arnd
