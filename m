From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Dec 2011 23:09:11 +0000
Subject: [GIT PULL 4/5] Tegra board updates for 3.3
In-Reply-To: <CAOesGMh7P6-=LbgUbYe1o7iO_-yALjce3H9ujXHW8hhikeTOsQ@mail.gmail.com>
References: <CAOesGMh7P6-=LbgUbYe1o7iO_-yALjce3H9ujXHW8hhikeTOsQ@mail.gmail.com>
Message-ID: <201112272309.11498.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 December 2011, Olof Johansson wrote:
> Please pull the below board updates for tegra for the 3.3 merge window.
> 
> Some of the board changes went into the soc branch due to close
> dependencies, most of these are pinmux cleanup and prep for pinctrl
> integration.
> 
> 
> They are based on the for-3.3/soc branch.

Ok, pulled into the next/boards branch.

> The following changes since commit 6cc04a4420391c3f034afe8ea6e28d75912a70a3:
> 
>   arm/tegra: Compile tegra_dt_init_irq only when CONFIG_OF (2011-12-19
> 18:07:22 -0800)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/boards
> 
> Leon Romanovsky (1):
>       ARM: tegra: paz00: Fix board pinmux table.
> 
> Marc Dietrich (1):
>       ARM: tegra: paz00: add support for wakeup gpio key
> 
> Olof Johansson (1):
>       arm/tegra: remove __initdata annotation from pinmux tables
>
> Stephen Warren (9):
>       arm/tegra: Split Seaboard GPIO table to allow for Ventana

I only just noticed that you are inconsistent with the formatting of the
patch subjects. We had a discussion about this a few months back and decided
to standardize on "ARM: tegra:" instead of "arm/tegra".

Please move to that style in future patches.

Thanks,

	Arnd
