From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 04 Jun 2013 10:43:05 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <20130604101030.232b3743@skate>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk>
 <20130603175629.GH5008@1wt.eu> <20130603181437.GO3803@titan.lakedaemon.net>
 <20130603183057.GA9868@1wt.eu> <20130603184148.GQ3803@titan.lakedaemon.net>
 <alpine.LFD.2.03.1306031502450.1200@syhkavp.arg>
 <20130604101030.232b3743@skate>
Message-ID: <51ADA899.80602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/13 10:10, Thomas Petazzoni wrote:
> On Mon, 03 Jun 2013 15:07:45 -0400 (EDT), Nicolas Pitre wrote:
>> Isn't upstream U-Boot supporting Marvell devices properly these days?
 >
> And as Jason said, even though Armada 370 and Armada XP have a working
> UART-based recovery method, users are also scared of doing bootloader
> updates, and on some consumer products, the UART is not necessarily
> easily available to the average users (may need some soldering skills,
> a level-shifter to use the TTL UART of the board, etc.).

Also remember that not all Kirkwoods support UART boot mode. If your
BootROM is too old, you will have to unbrick through JTAG. I have such
an old BootROM on my Dockstar.

Sebastian
