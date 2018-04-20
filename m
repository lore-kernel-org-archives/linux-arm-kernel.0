From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Apr 2018 15:40:24 +0200
Subject: [PATCH 0/8] arm: renesas: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAK8P3a17+rD9o=dKGYPhhjmtZsc7S-1YpPpH+Zfxbx6xVo7UWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 3:28 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi all,
>
> Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
> ARM SoCs.  This patch series completes the conversion, by:
>   1. Updating dependencies for drivers that weren't converted yet,
>   2. Removing the ARCH_SHMOBILE Kconfig symbols on ARM and ARM64.
>
> The first 6 patches can be applied independently by subsystem
> maintainers.
> The last two patches depend on the first 6 patches, and are thus marked
> RFC.

This all looks fine to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

      Arnd
