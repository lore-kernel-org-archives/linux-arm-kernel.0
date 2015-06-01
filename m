From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Jun 2015 12:17:40 +0200
Subject: [GIT PULL] ARM: mediatek: Fix for v4.1
Message-ID: <CABuKBeKkvikUSvZCZNn5_RSHs-ENX9gqDCwhS5h2Py9EQwdYpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull the following fix.

Thanks,
Matthias

---

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.1-next-arm64-fixes

for you to fetch changes up to 692ef3ee36833b6098a352c079d3cea8fc6ed3ef:

  arm64: dts: mt8173-evb: fix model name (2015-06-01 11:29:15 +0200)

----------------------------------------------------------------
- dts: mt8173: fix compatible string

----------------------------------------------------------------
Yingjoe Chen (1):
      arm64: dts: mt8173-evb: fix model name

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
