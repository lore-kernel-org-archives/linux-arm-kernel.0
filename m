From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:51:45 +0900
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.6
Message-ID: <cover.1456442918.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.6.

This pull request is based on the previous round of
such requests, tagged as v4.5-rc2,
which I have already sent a pull-request for.

I based this pull request on v4.5-rc2 instead of rc1 to avoid
a minor conflict. However I believe this may have been in vein
as there appears to be a separate minor conflict present in linux-next.

That conflict is with:

efdda175c07f ("arm64: defconfig: add spmi and usb related configs")

The solution is to take both.


The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.6

for you to fetch changes up to a9c42f02387ce8a231bce7c0901ef15fe4bfc3b4:

  arm64: defconfig: Add Renesas R-Car Gen3 USB 2.0 phy driver support (2016-02-24 09:44:34 +0900)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.6

* Enable Renesas R-Car Gen3 USB 2.0 phy driver
  which is used on the r8a7795/salvator-x

----------------------------------------------------------------
Yoshihiro Shimoda (1):
      arm64: defconfig: Add Renesas R-Car Gen3 USB 2.0 phy driver support

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
