From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Apr 2017 11:05:28 +0100
Subject: [GIT PULL] Immutable branch between MFD and IIO due for the v4.12
 merge window
In-Reply-To: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
References: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
Message-ID: <20170411100528.2zif3fyi7uoyw33n@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enjoy!

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-v4.12

for you to fetch changes up to f2499ab450d3052097ba53a7d763f767935c0c59:

  iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs (2017-04-11 11:02:33 +0100)

----------------------------------------------------------------
Immutable branch between MFD and IIO due for the v4.12 merge window

----------------------------------------------------------------
Quentin Schulz (1):
      iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs

 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/axp20x_adc.c | 617 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 628 insertions(+)
 create mode 100644 drivers/iio/adc/axp20x_adc.c

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
