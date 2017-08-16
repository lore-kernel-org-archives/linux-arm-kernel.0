From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:28:24 +0200
Subject: [GIT PULL 4/4] device tree changes for omaps for v4.14
In-Reply-To: <5246773866334625482@unknownmsgid>
References: <5246773866334625482@unknownmsgid>
Message-ID: <CAK8P3a1EuWq4pS_JTEcrKbQKZLpUncLE5d226Z-xnyauLTWcqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> ----------------------------------------------------------------
> Device tree changes for omaps for v4.14 merge window:
>
> - A series of changes for dra7 and am572 to use generic
>   MMC vqmmc regulator
>
> - Clean-up tps65217 internal interrupts to define them
>   only in tps65217.dtsi
>
> - Add dra7 iodelay pinctrl driver configuration
>
> - Add buzzer support for am437x-gp-evm
>
> - Disable HDMI CEC internal pull-ups as it seems that
>   all boards have an external pull for these
>
> - Remove unnecessary interrupt-parent for omap3
>
> - Configure droid 4 vaudio regulator initial mode and
>   add vibrator
>
> - Enable NAND dma prefetch for am335x-evm, am437x and dra7
>
> - Add pcie1 dt node for EP mode for am57x and dra7
>
> - Add support for new dra76x SoCs and dra76x-evm

Pulled into next/dt, thanks!

    Arnd
