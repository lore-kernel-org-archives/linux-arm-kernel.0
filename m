From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Jan 2015 14:52:26 -0800
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Defconfig
 Updates for v3.20
In-Reply-To: <cover.1421371751.git.horms+renesas@verge.net.au>
References: <cover.1421371751.git.horms+renesas@verge.net.au>
Message-ID: <20150121225226.GE24851@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 11:35:15AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC defconfig updates for v3.20.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-defconfig-for-v3.20,
> which I have already sent a pull-request for.
> 
> This pull request has a minor conflict in
> arch/arm/configs/shmobile_defconfig with the pull-request
> "Renesas ARM Based SoC Lager Board Removal for v3.20", tagged as
> renesas-lager-board-removal-for-v3.20, which you have pulled into the
> next/cleanup branch.
> 
> A resolution for this conflict is in the renesas-next-20150114-v3.19-rc1
> tag of my renesas tree.
> 
> In words the resolution is to add CONFIG_ARCH_SH73A0=y and
> remove CONFIG_MACH_LAGER=y.
> 
> The resulting area of arch/arm/configs/shmobile_defconfig should look like
> this:
> 
> CONFIG_ARCH_R8A7790=y
> CONFIG_ARCH_R8A7791=y
> CONFIG_ARCH_R8A7794=y
> CONFIG_ARCH_SH73A0=y
> CONFIG_MACH_MARZEN=y
> CONFIG_CPU_BPREDICT_DISABLE=y
> CONFIG_PL310_ERRATA_588369=y
> 
> 
> The following changes since commit db54d850b686c2ca81c10dd3582e98ee089a0e3a:
> 
>   ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig (2014-12-21 16:53:36 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v3.20
> 
> for you to fetch changes up to eb4513482d1c4882e3633528ccc48d77581b7bb1:
> 
>   ARM: shmobile: Enable kzm9g board in multiplatform defconfig (2015-01-14 09:51:08 +0900)

Merged, thanks.


-Olof
