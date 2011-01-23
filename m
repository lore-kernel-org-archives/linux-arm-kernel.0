From: jorgesolla@gmail.com (Jorge S.)
Date: Sun, 23 Jan 2011 16:58:15 +0100
Subject: AT91SAM9260 Board. Questions about design.
Message-ID: <AANLkTinuqqHzHFr6J7XkCytJY66UdmRL+dMuMpXwrmAh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello:

 I'm planning to build a new board based on the AT91SAM9260 processor, but
before doing it so, i would like to
confirm several issues:

SDIO Support:

 I would like to integrate a SDIO Wifi module (marvel 8686, atheros or any
other SDIO module). I'm unable to find
any conclusive information regarding this matter. There are several posts on
forums and mailing lists from people
trying it and getting only partial success (slow performance, errors, etc).

Question: Can somebody confirm if SDIO+WIFI is properly working with this
kind of WIFI modules on AT91SAM9260?

GPIO Support:

  I'm aware of the existence of a kind of GPIO subsystem on the kernel
(linux/gpio.h) documented on "gpio.txt"
file. I know i can use /dev/mem to access the hardware registers, but a
ready-made API would help a lot.

Questions: Are the GPIO pins on the 9260 integrated on this kernel GPIO
subsystem? Or do i have to provide my own
GPIO driver to allow user-land applications using GPIO, or just use
/dev/mem?


ADC Support:

 I would like to be able to use the ADC on the 9260. I've seen several posts
on forums using an ADC driver
from ATMEL, but again nothing conclusive.

Question: Is this ADC driver available on the mainline kernel?


FLASH Support:

 I'm planning to use at least 1GB NAND on my board, but it's difficult to
find reference designs using one.
Question: Any warnings here...? Source code reference or something to start
with? Problems booting? Do i have
 to provide a serial dataflash for booting? or the NAND is just enough?



Any "BE AWARE OF.."

 Some time ago (years) i faced problems with a RM9200 based board having
issues with hardware SPI and
with lack of support for the RTC, and some others things that consumed lots
of time with software
work-arounds,etc..

Question: Are there any "erratas" or bad-supported things that must be taken
into account before starting
the hardware desing of a new board?


Thank you all.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110123/d457efca/attachment-0001.html>
