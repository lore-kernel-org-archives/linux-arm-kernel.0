From: beanhuo@micron.com (=?gb2312?B?QmVhbiBIdW8gu/Sx87HzIChiZWFuaHVvKQ==?=)
Date: Tue, 8 Dec 2015 06:44:41 +0000
Subject: [PATCH linux-next 0/5] mtd: spi-nor: add driver for Atmel QSPI
 controller
In-Reply-To: <20151207193441.GO120110@google.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
 <20151207193441.GO120110@google.com>
Message-ID: <A765B125120D1346A63912DDE6D8B6310BF53450@NTXXIAMBX02.xacn.micron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> I'll admit I'm a little fuzzy on the differences between dual and quad modes on
> various flash manufacturers. Can you help clear it up for me?

For SPI NOR, currently, don't have an official standard to define an uniform Quad
I/O mode protocol. So we can see that there are some difference between Flash
Vendor.
