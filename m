From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 23 Mar 2018 14:54:44 -0500
Subject: [GIT PULL 2/2] arm64: stratix10: defconfig update for v4.17
In-Reply-To: <1521834884-23795-1-git-send-email-dinguyen@kernel.org>
References: <1521834884-23795-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1521834884-23795-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling in this ARM64 defconfig update for v4.17.

Thanks,
Dinh

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_defconfig_for_v4.17

for you to fetch changes up to 83d6e27e6856edf30845df8708b3b1e226ba5c7f:

  arm64: defconfig: enable stmmac ethernet to defconfig (2018-03-23 10:37:05 -0500)

----------------------------------------------------------------
ARM64: stratix10: defconfig updates for 4.17
-enables STMMAC_ETH controller that is present on Stratix10

----------------------------------------------------------------
Dinh Nguyen (1):
      arm64: defconfig: enable stmmac ethernet to defconfig

 arch/arm64/configs/defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
