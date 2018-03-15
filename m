From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 16:25:10 +0100
Subject: [GIT PULL 1/6] i.MX drivers updates for 4.17
In-Reply-To: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a32SL4vaD+o8wRWDnnv0e0k5qyER9Ly-2j9PZAOrkyV6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 12:36 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.17
>
> for you to fetch changes up to f40a1e3705be23e845fbeec66acf3a6582524145:
>
>   soc: imx: gpc: ARM power domain should be always-on (2018-02-12 13:07:48 +0800)
>
> ----------------------------------------------------------------
> i.MX drivers update for 4.17:
>  - Set GENPD_FLAG_ALWAYS_ON flag for ARM power domain to avoid incorrect
>    power state in sysfs pm_genpd_summary output.

Pulled into next/drivers. I can't really tell from the patch description whether
this is urgent or not. Can you confirm that we don't want this in 4.16 or older
kernels?

        Arnd
