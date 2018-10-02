From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 10:17:40 +0200
Subject: [GIT PULL 1/5] i.MX drivers updates for 4.20
In-Reply-To: <20181001072003.16238-1-shawnguo@kernel.org>
References: <20181001072003.16238-1-shawnguo@kernel.org>
Message-ID: <CAK8P3a29Q4MLKXfKPaOpEiX=7RMX0TViby94ok2jFKR6XhDr+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 9:20 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> The following changes since commit 57361846b52bc686112da6ca5368d11210796804:
>
>   Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.20
>
> for you to fetch changes up to 8d8e3b7d8f06f69005d829d4a195b00ef976004b:
>
>   soc: imx: gpcv2: Switch to SPDX identifier (2018-10-01 13:24:15 +0800)
>
> ----------------------------------------------------------------
> i.MX drivers update for 4.20:
>  - A couple of patches from Anson to update variable and macro naming
>    in GPCv2 driver, as a preparation of reusing the driver on i.MX8.
>  - Switch GPC/GPCv2 drivers to use SPDX identifier for licence claiming.
>  - Clean up the unnecessary DT node name NULL pointer checking from
>    imx-weim driver, since it can never be NULL at all.
>  - A couple of improvements on GPC driver from Sven Schmitt to correct
>    PDN register and use GPC_PGC_DOMAIN_* indexes for consistency.

Pulled into next/drivers, thanks!

      Arnd
