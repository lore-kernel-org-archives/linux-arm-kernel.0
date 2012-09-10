From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Sep 2012 02:07:51 -0400
Subject: [GIT PULL V2 4/4] ARM: Kirkwood: defconfig changes for v3.7
In-Reply-To: <20120829001129.GO19437@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
Message-ID: <20120910060751.GF15277@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This PR is based on v3.6-rc5 and depends on kirkwood/cleanup.

thx,

Jason.

The following changes since commit f82671fa39f5cccd4a3e93249d56c5664e1d78dc:

  ARM: Kirkwood: use linux/platform_data/mv643xx.h instead of linux/mv643xx.h (2012-09-10 05:06:12 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/defconfig

Jason Cooper (2):
      ARM: Kirkwood: update defconfig
      ARM: Kirkwood: add DT boards to defconfig

 arch/arm/configs/kirkwood_defconfig |   38 +++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 19 deletions(-)
