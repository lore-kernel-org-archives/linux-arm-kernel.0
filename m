From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 May 2018 13:24:03 +0200
Subject: [GIT PULL] defconfig updates for v4.18
Message-ID: <268190dc-bca5-d86a-c56c-75013dc20d38@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Please merge the following patch for defconfig.

Thanks,
Matthias

---

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.17-next-defconfig

for you to fetch changes up to 1e31927aa64545ee97a2a41db9984c9931afc50a:

  arm64: defconfig: Enable CONFIG_PINCTRL_MT7622 by default (2018-04-27 11:48:37
+0200)

----------------------------------------------------------------
enable mt7622 pinctrl to fix boot issue

----------------------------------------------------------------
Sean Wang (1):
      arm64: defconfig: Enable CONFIG_PINCTRL_MT7622 by default

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
