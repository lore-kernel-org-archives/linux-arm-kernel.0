From: mporter@linaro.org (Matt Porter)
Date: Fri, 23 May 2014 09:16:58 -0400
Subject: [GIT PULL] ARM: mach-bcm: dt updates for 3.16
Message-ID: <20140523131658.GA24244@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider pulling the following mach-bcm dt updates for 3.16.

-Matt

The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/for-3.16/bcm-dt

for you to fetch changes up to de9bd52f21b5677a18a205c2a931c87254dabdeb:

  ARM: dts: bcm590xx: add support for GPLDO and VBUS regulators (2014-05-23 08:07:01 -0400)

----------------------------------------------------------------
mach-bcm dt updates for 3.16:

* Add PWM support to bcm281xx and bcm28155 ap board
* Add gpldo and vbus regulators to bcm590xx

----------------------------------------------------------------
Matt Porter (1):
      ARM: dts: bcm590xx: add support for GPLDO and VBUS regulators

Tim Kryger (2):
      ARM: dts: Declare the PWM for bcm11351 (bcm281xx)
      ARM: dts: Enable the PWM for bcm28155 AP board

 arch/arm/boot/dts/bcm11351.dtsi   |  8 ++++++++
 arch/arm/boot/dts/bcm28155-ap.dts |  4 ++++
 arch/arm/boot/dts/bcm59056.dtsi   | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+)
