From: alainsergenagni@yahoo.com (Jean-Paul)
Date: Mon, 28 May 2012 07:25:08 +0000 (UTC)
Subject: [PATCH 2/3] ARM: mx28: Add SPI resources
References: <1333480807-10480-1-git-send-email-festevam@gmail.com>
 <1333480807-10480-2-git-send-email-festevam@gmail.com>
Message-ID: <loom.20120528T090703-293@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Fabio Estevam,
 I have im28 evk board and I fallowed your instructions to add the SPI resources
in my kernel. I'm using the kernel 3.2.15. After rebuilding the kernel, I still
can not see the imx28 spi drivers. Im sorry to ask these beginner questions but
I'm new in using linux spi drivers.

 I checked at these locations:
     /sys/class/spidev   and    /sys/class/spi_master
I could not see any SPI device, it was just empty.

when I do: ls /sys/bus/spi/drivers
I can see:   enc28j60 , mc33880 , mmc_spi , and spidev

How can I create a device spi node since it looks like that i don't have spi
driver for the imx28 evk board?


Thanks for your help,
Jean-Paul
 
