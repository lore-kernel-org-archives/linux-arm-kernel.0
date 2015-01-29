From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Jan 2015 13:59:00 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Fixes for v3.20
In-Reply-To: <cover.1422492899.git.horms+renesas@verge.net.au>
References: <cover.1422492899.git.horms+renesas@verge.net.au>
Message-ID: <20150129215900.GF20785@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 10:31:22AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC defconfig fixes for v3.20.
> 
> This pull request is based on "Second Round of Renesas ARM Based SoC
> Defconfig Updates for v3.20", tagged as renesas-defconfig2-for-v3.20, which
> you have previously pulled.
> 
> 
> That pull-request was comprised of a single patch "ARM: shmobile: Enable
> kzm9g board in multiplatform defconfig" which updated the mach_shmobile
> based on the output of make savedefconfig run on a tree with sh73a0/kzm9g
> multiplatform support present. And due to REGULATOR being indirectly
> selected by Kconfig with that support prsent it was not present in the
> resulting shmobile_defconfig.
> 
> However, sh73a0/kzm9g multiplatform supportsupport is no longer queued up
> for v3.20 and thus is not enabled by make shmobile_defconfig resulting at
> least in SDHI not working on boards based on R-Car Gen2 SoCs.
> 
> It may have been better if I had held off on the patch in question
> until sh73a0/kzm9g multiplatform support was merged, something I expected
> to occur for v3.20. But things being as they are this pull-request
> provides a simple fix for the fallout.
> 
> 
> The following changes since commit eb4513482d1c4882e3633528ccc48d77581b7bb1:
> 
>   ARM: shmobile: Enable kzm9g board in multiplatform defconfig (2015-01-14 09:51:08 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-fixes-for-v3.20
> 
> for you to fetch changes up to 30aca3c84bd79b48154908b6c1592347f4df3d53:
> 
>   ARM: shmobile: Select CONFIG_REGULATOR in defconfig once again (2015-01-26 16:14:04 +0900)

Merged, thanks.


-Olof
