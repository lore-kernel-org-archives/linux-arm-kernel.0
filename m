From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Dec 2013 20:21:13 -0500
Subject: [GIT PULL] ARM: mvebu: drivers changes for v3.14 (incr. #2)
In-Reply-To: <20131227193726.GE19878@titan.lakedaemon.net>
References: <20131227193726.GE19878@titan.lakedaemon.net>
Message-ID: <20131228012113.GF19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops.  And here's the pull request I forgot to inline:

On Fri, Dec 27, 2013 at 02:37:26PM -0500, Jason Cooper wrote:
> Guys,
> 
> After some discussion with the maintainer of drivers/rtc (Alessandro
> Zummo), he's expressed a preference for patches to go through arch
> trees due to his limited time.  Hence, we're taking this rtc driver
> through mvebu/arm-soc.
> 
> As usual, it's been in -next for while, although, it's not enabled in
> any defconfigs.  I've built it without warnings against mvebu_defconfig.
> 
> This pull is an incremental pull request from tags/mvebu-drivers-3.14 to
> tags/mvebu-drivers-3.14-2 in the mvebu/drivers branch.



The following changes since commit 9c8eca3ca43d7337be2485169d4d86a9b6f477d2:

  bus: mvebu-mbus: Remove deprecated comment (2013-11-24 16:39:41 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-3.14-2

for you to fetch changes up to 70e123373c05e336f3f769b32c6132bdc2d6f5ac:

  rtc: Add support for Intersil ISL12057 I2C RTC chip (2013-12-22 17:33:16 +0000)

----------------------------------------------------------------
mvebu driver changes for v3.14 (incremental #2)

 - rtc
    - add driver for Intersil ISL12057 chip

----------------------------------------------------------------
Arnaud Ebalard (1):
      rtc: Add support for Intersil ISL12057 I2C RTC chip

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-isl12057.c                         | 310 +++++++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 drivers/rtc/rtc-isl12057.c
