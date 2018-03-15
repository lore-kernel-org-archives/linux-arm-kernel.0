From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 16:29:12 +0100
Subject: [GIT PULL 5/6] Freescale arm64 device tree updates for 4.17
In-Reply-To: <1521113800-16401-5-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
 <1521113800-16401-5-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a1RZjpSj=6eWAJ7Y=6=N9PPXkVcHN84LFBFJROyN0d0iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 12:36 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.17
>
> for you to fetch changes up to 4e017f1419397473cf3db6e9fa020013998b1aa4:
>
>   dt-bindings: ifc: Fix the unit address format in the examples (2018-03-12 15:38:49 +0800)
>
> ----------------------------------------------------------------
> Freescale arm64 device tree updates for 4.17:
>  - Move cpu_thermal device out of bus node to fix DTC simple_bus_reg
>    warning seen with W=1 switch.
>  - Fix IFC child nodes' unit-address to eliminate DTC simple_bus_reg
>    warnings.
>  - Add a dummy size memory 'reg' property for LS1046A device tree to
>    avoid unit_address_vs_reg DTC warning, and the real size will be
>    filled by bootloader.
>  - Update ls208xa-qds board device tree to fix unit_address_vs_reg
>    warnings with DSPI device.
>  - Add idle-states for LS1012A and LS1043A, and correct
>    arm,psci-suspend-param setting for already added idle-states.
>  - DPAA QBMan portal and watchdog device addition.

Pulled into next/dt

What's the status of the imx8 support? Do you plan to send another
pull request for that for 4.17, or are you still waiting for some
dependencies?

Thanks,

       Arnd
