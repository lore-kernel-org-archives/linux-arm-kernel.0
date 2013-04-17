From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Wed, 17 Apr 2013 08:25:10 -0400
Subject: at91:  DT for MAC EEPROM?
Message-ID: <91586D499ADFD74FBCFB8425266A5DE40139FD848A18@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have a AT91SAM9G25 based board that has a I2C MAC EEPROM chip (Microchip 24AA02E48).  Our board is based on the SAM9G25-EK with the 24AA02E48 replacing the I2C EEPROM on the SAM9G25-EK.  I have some questions with integrating the MAC EEPROM with the latest device tree setup and the Ethernet driver.

1.  The 24AA02E48 uses the same I2C messaging protocol and the same address as the I2C EEPROM used on the SAM9G25-EK.  Is there any need to replace the device tree info in the dts files for my setup?

2.  Is there any Ethernet related device tree setup that I need that is related to the MAC address?

3.  I am planning on removing U-Boot from our production setup and having the AT91 Bootstrap boot the Linux kernel.  Is there anything device tree (or non-device tree) related that I need to add so that the kernel finds the MAC address that is on the EERPOM?

Thanks,
Bryan Evenson
