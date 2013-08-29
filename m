From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 29 Aug 2013 10:32:42 +0200
Subject: [GIT PULL v2] at91: soc update for 3.12 #1
In-Reply-To: <20130828235855.GM8607@quad.lixom.net>
References: <20130828235855.GM8607@quad.lixom.net>
Message-ID: <1377765162-1659-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

(respin of previous pull-request with author name fixed)

Here is AT91 SoC updates for 3.12 kernel. It is the first pull-request for
this topic and it is based on 3.11-rc5 like your next/soc branch.

Thanks, best regards,

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-soc

for you to fetch changes up to 746831d5a166b1965034318ab80a7a7af03bf30f:

  ARM: at91: at91_dt_defconfig: enable rm9200 support (2013-08-26 09:58:29 +0200)

----------------------------------------------------------------
AT91 SoC update for 3.12 take 1
- enable kernel uncompress information output for
  SoC where it was missing: at91sam9n12 and sama5d3
- addition of at91rm9200 to the generic at91_dt_defconfig

----------------------------------------------------------------
Bo Shen (4):
      ARM: at91: sama5d3: add definition for usart base address
      ARM: at91: include sama5d3.h into hardware.h
      ARM: at91: sama5: enable kernel uncompress info output
      ARM: at91: sam9n12: enable kernel uncompress info output

Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: at91_dt_defconfig: enable rm9200 support

 arch/arm/configs/at91_dt_defconfig           |  4 +++-
 arch/arm/mach-at91/include/mach/hardware.h   |  1 +
 arch/arm/mach-at91/include/mach/sama5d3.h    |  8 ++++++++
 arch/arm/mach-at91/include/mach/uncompress.h | 13 +++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
Nicolas Ferre
