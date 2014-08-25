From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:09:57 +0900
Subject: [GIT PULL] Second Round Of Renesas ARM Based SoC Defconfig Updates
 For v3.18
Message-ID: <cover.1408926588.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC defconfig updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig-for-v3.18,
which I have already sent a pull-request for.


The following changes since commit 874ee23c83d888f8824305c277e047c7799f30b9:

  ARM: shmobile: defconfig: enable initrd (2014-08-18 08:07:38 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v3.18

for you to fetch changes up to 99923753e7c17a9c9d46bfe4d7fa543e426ec647:

  ARM: shmobile: bockw: Do not disable SUSPEND in defconfig (2014-08-22 10:40:31 +0900)

----------------------------------------------------------------
Second Round Of Renesas ARM Based SoC Defconfig Updates For v3.18

* Do not disable SUSPEND in Bockw defconfig
  - Suspend to ram is now supported

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: bockw: Do not disable SUSPEND in defconfig

 arch/arm/configs/bockw_defconfig | 1 -
 1 file changed, 1 deletion(-)
