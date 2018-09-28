From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 22:15:57 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.20
In-Reply-To: <cover.1538123953.git.horms+renesas@verge.net.au>
References: <cover.1538123953.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a3zLzWY4mPMBkwk8Z_ijLr7R2nOczAorYAgfxw=qmrxng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 12:22 PM Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC updates for v4.20.
>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-soc-for-v4.20
>
> for you to fetch changes up to 6d14d4d313d09dabdb06b4a9f4e5fe4305051e9b:
>
>   ARM: shmobile: Rework the PMIC IRQ line quirk (2018-09-19 11:11:46 +0200)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v4.20
>
> * Rework the PMIC IRQ line quirk to use DT rather than hard coded topology
> * Convert to SPDX identifiers
> * Convert to using %pOFn instead of device_node.name
> * Remove the no longer needed ARCH_SHMOBILE Kconfig symbol
> * RZ/G1N (r8a7744) SoC: Add basic SoC and debug-ll support
> * R-Car H1 (r8a7779) SoC: remove unused includes

Pulled into next/soc, thanks,

      Arnd
