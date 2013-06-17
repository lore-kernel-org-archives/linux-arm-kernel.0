From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Jun 2013 14:36:45 +0200
Subject: [PATCH 0/5] ARM: at91: rm9200 dt updates
Message-ID: <20130617123645.GA21034@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	The following patch series enable rm9200 in the dt defconfig and add
	- spi
	- pqfp package version

The following changes since commit 24ce10e142e7b063c4ae4437dd3b290fbfafe052:

  ARM: at91: sam9m10g45ek add udc DT support (2013-06-15 00:15:22 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git j/for-3.11-rm9200

for you to fetch changes up to 0dab9f12eab58fdf876be8bb39432f7426615230:

  ARM: at91: at91rm9200: set default mmc0 pinctrl-names (2013-06-17 20:37:26 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (5):
      ARM: at91: at91_dt_defconfig: enable rm9200 support
      ARM: at91: dt: rm9200: add spi support
      ARM: at91: dt: rm9200ek: add spi support
      ARM: AT91: dt: add at91rm9200 PQFP package version
      ARM: at91: at91rm9200: set default mmc0 pinctrl-names

 arch/arm/boot/dts/at91rm9200.dtsi      |   21 +++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200_pqfp.dtsi |   17 +++++++++++++++++
 arch/arm/boot/dts/at91rm9200ek.dts     |   10 ++++++++++
 arch/arm/configs/at91_dt_defconfig     |    4 +++-
 4 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91rm9200_pqfp.dtsi

Best Regards,
J.
