From: horms@verge.net.au (Simon Horman)
Date: Thu, 9 Feb 2017 11:55:46 +0100
Subject: [PATCH 0/2] ARM: shmobile: Remove ARCH_SHMOBILE_MULTI
In-Reply-To: <1486635529-6636-1-git-send-email-geert+renesas@glider.be>
References: <1486635529-6636-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170209105546.GI16056@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 11:18:47AM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series completes the migration from ARCH_SHMOBILE_MULTI to
> ARCH_RENESAS, which was started by commit 9b5ba0df4ea4 ("ARM: shmobile:
> Introduce ARCH_RENESAS").
> 
> Thanks for applying!

Thanks, nice to see this coming to an end.

I have queued up patch 1/2 in the dt-for-v4.12 branch.

I am of a mind to defer patch 2/2 because it looks like it should
go in the soc-for-v4.12 branch and I'd rather not add a dependency
on the dt-for-v4.12 branch for a cleanup.

In a perfect world we could have one branch to rule them all;
we do not live in that world.

> Geert Uytterhoeven (2):
>   ARM: dts: renesas: Switch from ARCH_SHMOBILE_MULTI to ARCH_RENESAS
>   ARM: shmobile: Remove ARCH_SHMOBILE_MULTI
> 
>  arch/arm/boot/dts/Makefile     | 38 +++++++++++++++++++-------------------
>  arch/arm/mach-shmobile/Kconfig |  4 ----
>  2 files changed, 19 insertions(+), 23 deletions(-)
