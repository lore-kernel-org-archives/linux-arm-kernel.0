From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 11 Feb 2016 15:49:12 +0100
Subject: [GIT PULL 1/4] rockchip soc-driver changes for 4.6
In-Reply-To: <1734524.3yNt5L3F1F@phil>
References: <1734524.3yNt5L3F1F@phil>
Message-ID: <2006551.mXAMdNYBE2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

This one change enables the rockchip timer driver on 64bit socs as well,
after it got fixed to actually work on 64bit in 4.5-rc1.
 
Thanks
Heiko


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.6-rockchip-soc64-1

for you to fetch changes up to c840f28bbf643c361c463bcb8fb815d0b2dad4e8:

  arm64: Enable the timer on Rockchip architecture (2016-01-24 23:33:14 +0100)

----------------------------------------------------------------
Enable the rockchip-specific timers on arm64 rockchip platforms.
The driver got reworked to not use arm32-specific dsb calls in
4.5-rc1, so now we can safely enable it.

----------------------------------------------------------------
Caesar Wang (1):
      arm64: Enable the timer on Rockchip architecture

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)
