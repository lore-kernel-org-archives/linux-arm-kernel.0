From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Jun 2013 15:45:14 +0900
Subject: [GIT PULL 0/6] Renesas ARM based SoC defconfig updates for v3.11
In-Reply-To: <1370406713-26599-1-git-send-email-horms+renesas@verge.net.au>
References: <1370406713-26599-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130605064511.GA14490@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ fix up subject to say GIT PULL ]

On Wed, Jun 05, 2013 at 01:31:47PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:
> 
>   Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.11
> 
> for you to fetch changes up to 76d415dfa7d53a2f92550484d766ae475a427daf:
> 
>   ARM: shmobile: kzm9g: enable AS3711 PMIC in defconfig (2013-06-04 21:47:10 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC defconfig updates for v3.11
> 
> kzm9g: Enable AS3711 PMIC
> bockw: Enable, USB, PM_RUNTIME, I2C and SDHI
> armadillo800eva: Correct SERIAL_SH_SCI_NR_UARTS
> 
> ----------------------------------------------------------------
> Guennadi Liakhovetski (1):
>       ARM: shmobile: kzm9g: enable AS3711 PMIC in defconfig
> 
> Kuninori Morimoto (1):
>       ARM: shmobile: bockw: enable SDHI on defconfig
> 
> Nobuhiro Iwamatsu (1):
>       ARM: shmobile: armadillo800eva: Fix maximum number of SCIF
> 
> Sergei Shtylyov (1):
>       ARM: shmobile: bockw: enable USB in defconfig
> 
> Vladimir Barinov (2):
>       ARM: shmobile: bockw: enable I2C in defconfig
>       ARM: shmobile: bockw: enable CONFIG_PM_RUNTIME in defconfig
> 
>  arch/arm/configs/armadillo800eva_defconfig |  2 +-
>  arch/arm/configs/bockw_defconfig           | 16 +++++++++++++++-
>  arch/arm/configs/kzm9g_defconfig           |  3 +++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
