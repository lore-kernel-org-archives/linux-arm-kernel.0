From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 18:04:05 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.20
In-Reply-To: <cover.1538122547.git.horms+renesas@verge.net.au>
References: <cover.1538122547.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a0YQebBWKaixWpk7zFK4T4YYDCY3v8Ce2YmCBudcAU78A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 12:21 PM Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC defconfig updates for v4.20.
>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-defconfig-for-v4.20
>
> for you to fetch changes up to c26eb6f34c9ea56ed795785ecb7938f008dfed1e:
>
>   ARM: shmobile: defconfig: Enable r8a7744 SoC (2018-09-19 10:40:47 +0200)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Defconfig Updates for v4.20
>
> * shmobile and multi_v7 defconfigs:
>   - Enable recently upstreamed r8a7744 SoC
>   - Enable FDP1 (Fine Display processor) present on R-Car Gen2 and RZ/G1 SoCs
> * shmobile defconfig (only):
>   - Refresh for v4.19-rc1
>   - Remove soon to be deprecated SOC_CAMERA

Pulled into next/defconfig, thanks!

      Arnd
