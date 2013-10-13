From: mindentropy@gmail.com (mind entropy)
Date: Sun, 13 Oct 2013 12:00:24 +0530
Subject: On s3c2440 spi CPHA issues.
Message-ID: <CAM2a4uzkp8C5OYOsPBdd0Gh7goG-XCfj9cv3DpqG0hTh+ZeWzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
  I am interfacing a mini2440(master) and a ti MSP430(slave). I am
using  spidev and testing using spidev_test. When I use the SPI_MODE_1
i.e CPHA enabled I lose a bit. When I send 0xAA pattern I get a 0x55
pattern. What seems to be the problem? I have tested the slave code by
connecting another msp430 as a master and sending data at 12Mhz in
different modes and it is fine. Is the spi transfer in s3c2440 tested?

Thanks,
Gautam.
