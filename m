From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 11:22:41 +0100
Subject: [GIT PULL 1/4] i.MX SoC changes for 4.15
In-Reply-To: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
References: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a0SO85aWR+zZFHTrET5QMVbi7oGCjiLUEQXootuv4BLfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 2:20 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
>
> ----------------------------------------------------------------
> i.MX SoC changes for 4.15:
>  - A series from Marco Franchi from to clean up build warnings see with
>    W=1 in arch/arm/mach-imx/.
>  - Move i.MX6 speed grading check from i.MX platform code to cpufreq
>    driver.  The patch is suggested by cpufreq folks to go through
>    arm-soc tree.
>  - Enable cpuidle support on i.MX6DL starting from IMX_CHIP_REVISION_1_1.
>  - Constify platform_suspend_ops for MXS platform.
>

Pulled into next/soc, thanks!

     Arnd
