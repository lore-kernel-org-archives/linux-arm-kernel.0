From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2018 17:38:08 +0200
Subject: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
In-Reply-To: <1540403734-137721-2-git-send-email-lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <1540403734-137721-2-git-send-email-lsun@mellanox.com>
Message-ID: <CAK8P3a1jTsvzYhS4CxvmK6tOgPn_g7=1S4xAcca2K4v70vhyEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/18, Liming Sun <lsun@mellanox.com> wrote:
> This commit introduces config option for Mellanox BlueField SoC,
> which can be used to build the SoC specific drivers, and enables
> it by default in configs/defconfig.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> ---
>  arch/arm64/Kconfig.platforms | 6 ++++++
>  arch/arm64/configs/defconfig | 1 +
>  2 files changed, 7 insertions(+)

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I'm sorry for missing your series in the past. We should definitely merge
the platform support soon. Do you also have device tree files for reference
systems or even production hardware?

I need to have a separate look at the fifo driver.

Unfortunately, you have sent these patches during the merge window,
which is the time during which we don't pick up new work. Let's plan
to pick these up after 4.20-rc1, and please resend to arm at kernel.org
if we manage to forget about it again.

      Arnd
