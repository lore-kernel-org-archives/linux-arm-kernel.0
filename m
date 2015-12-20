From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 20 Dec 2015 22:21:12 +0100
Subject: [GIT PULL] ARM: mediatek: kconfig update for v4.4
Message-ID: <CABuKBe+mw4nWDO8JPciz1FC-x7UrF-MvF7r_LeqWU=JT8jwUCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following patch.

Thanks,
Matthias

---

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.4-next-kconfig

for you to fetch changes up to c050b45d87adf88d60347005cfaac3bdad21e7c5:

  arm64: mediatek: enable MTK_TIMER (2015-12-18 09:41:18 +0100)

----------------------------------------------------------------
Enable mediatek clocksource driver by default as otherwise the system
does not boot.

----------------------------------------------------------------
Yingjoe Chen (1):
      arm64: mediatek: enable MTK_TIMER

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)
