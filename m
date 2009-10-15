From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 15 Oct 2009 19:13:25 +0200
Subject: [PATCH 0/4] [MXC] Armadillo500 patches to support various devices.
Message-ID: <20091015191325.74ba24fb@Marramao-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this series of patches I introduce support for:

1 GPIO Buttons with GPIO Keyboard.
2 Correct SMSC9118 Bus width flag to 16 bit instead of 32.
3 Add support for the second i2c device where is connected the onboard RTC module.
4 Add support for Seiko Instruments S-35390A RTC module.
