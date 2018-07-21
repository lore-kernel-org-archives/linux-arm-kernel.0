From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:21:23 -0700
Subject: [GIT PULL 2/6] i.MX SoC changes for 4.19
In-Reply-To: <1532140344-2771-2-git-send-email-shawnguo@kernel.org>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
 <1532140344-2771-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20180721212123.hpi4o3hqazjtdqqc@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 10:32:20AM +0800, Shawn Guo wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.19
> 
> for you to fetch changes up to 26b754f99402d6e7fc4e07d67a2597e6ebabde8b:
> 
>   ARM: mx5: Set the DBGEN bit in ARM_GPC register (2018-07-12 09:52:20 +0800)
> 
> ----------------------------------------------------------------
> i.MX SoC update for 4.19:
>  - A series from Anson Huang to add power management for i.MX6SLL,
>    including standby and mem mode suspend, cpuidle support, and bus
>    clock auto gating function, etc.
>  - A couple of fix-ups on i.MX6SLL cpuidle random build issues.
>  - A couple of cleanups on stale EPIT timer initialization and RNGA
>    platform device registration function.
>  - Configure i.MX51 SoC M4IF to avoid visual artifacts during video
>    playback.
>  - Set up i.MX51 and i.MX53 DBGEN bit of ARM_GPC register, so that
>    clocks within the debug system can be activated.
>  - Add a Cortex-M4 platform support which will be useful for running
>    a Linux instance on Cortex-M4 core integrated in i.MX7D SoC.
>  - Flag of_iomap failure in imx_aips_allow_unprivileged_access()
>    function by giving a warning in there.

Merged, thanks!


-Olof
