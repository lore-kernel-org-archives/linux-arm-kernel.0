From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 Sep 2014 22:28:55 +0200
Subject: [GIT PULL] Allwinner drivers additions for 3.18
Message-ID: <20140920202855.GA20329@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following changes for the next merge window.

Thanks!
Maxime


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drivers-for-3.18

for you to fetch changes up to 64a1925c00706253aa887431fc45f96db48aa727:

  rtc: sunxi: Depend on platforms sun4i/sun7i that actually have the rtc (2014-09-19 12:39:30 +0200)

----------------------------------------------------------------
Allwinner drivers additions for 3.18

Nothing major, just handling the RTC driver changes needed for the A31/A23.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      rtc: sun6i: Add sun6i RTC driver
      rtc: sunxi: Depend on platforms sun4i/sun7i that actually have the rtc

 .../devicetree/bindings/rtc/sun6i-rtc.txt          |  17 +
 drivers/rtc/Kconfig                                |   9 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-sun6i.c                            | 447 +++++++++++++++++++++
 4 files changed, 473 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
 create mode 100644 drivers/rtc/rtc-sun6i.c

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140920/341e63c3/attachment.sig>
