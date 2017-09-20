From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 20 Sep 2017 13:43:02 +0530
Subject: [GIT PULL] DaVinci fixes for v4.14
Message-ID: <e28d3e5b-03b6-4def-edb0-d586f3c7627b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.14

for you to fetch changes up to ce21574ad1922b403198ee664c4dff276f514f1d:

  ARM: dts: da850-evm: add serial and ethernet aliases (2017-09-20 13:33:41 +0530)

----------------------------------------------------------------
A fix for random ethernet mac address problem
on DA850 EVM.

----------------------------------------------------------------
Sekhar Nori (1):
      ARM: dts: da850-evm: add serial and ethernet aliases

 arch/arm/boot/dts/da850-evm.dts | 7 +++++++
 1 file changed, 7 insertions(+)
