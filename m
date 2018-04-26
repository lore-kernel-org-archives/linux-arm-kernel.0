From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Apr 2018 16:45:10 +0200
Subject: [GIT PULL] ARM: socfpga_defconfig: fix for v4.17
In-Reply-To: <1523891999-6068-1-git-send-email-dinguyen@kernel.org>
References: <1523891999-6068-1-git-send-email-dinguyen@kernel.org>
Message-ID: <CAK8P3a0O+2tK=otV2JXDN0zXjAcnCV=OPCe8LFuP8TC692Ya5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 5:19 PM, Dinh Nguyen <dinguyen@kernel.org> wrote:
> Hi Arnd, Kevin, and Olof:
>
> Please pull in this fix for v4.17.
>
> Thanks,
> Dinh
>
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_defconfig_fix_v4.17
>
> for you to fetch changes up to 6e8fe39989720b87439fee7817a5ca362b16d931:
>
>   ARM: socfpga_defconfig: Remove QSPI Sector 4K size force (2018-04-16 09:14:30 -0500)
>
> ----------------------------------------------------------------
> ARM: socfpga_defconfig: fix QSPI Sector 4k
> - disable CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
>

Pulled into fixes, thanks!

       Arnd
