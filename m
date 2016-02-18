From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Feb 2016 03:23:11 +0100
Subject: [GIT PULL] at91: dt for 4.6 #1
Message-ID: <20160218022311.GA2466@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the addition of the ADC support for sama5d2. The driver went
through the iio tree.

Thanks!

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.6-dt

for you to fetch changes up to 5e72c25b40c1e9ed77650f258799514aabd17303:

  ARM: dts: at91: sama5d2 Xplained: enable the adc device (2016-02-18 03:10:05 +0100)

----------------------------------------------------------------
DT changes for 4.6:
 - Addition of the ADC for sama5d2 and sama5d2_xplained

----------------------------------------------------------------
Ludovic Desroches (2):
      ARM: dts: at91: sama5d2: add adc device
      ARM: dts: at91: sama5d2 Xplained: enable the adc device

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 18 ++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160218/80da022e/attachment.sig>
