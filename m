From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 15 May 2012 23:51:04 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAyLzJdIEFSTTogY2xwczcxMXg6IEFkZGVkIHN1cHBv?=
 =?UTF-8?B?cnQgZm9yIENQVSBmcmVxdWVuY2llcyBvdGhlciB0aGFuIDczIE1Ieg==?=
In-Reply-To: <201205151936.48048.arnd@arndb.de>
References: <1337104502-5292-1-git-send-email-shc_work@mail.ru>
 <1337104502-5292-3-git-send-email-shc_work@mail.ru>
 <201205151936.48048.arnd@arndb.de>
Message-ID: <E1SUNlw-0007NA-Ej.shc_work-mail-ru@f304.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Tue, 15 May 2012 19:36:47 +0000 ?? Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 15 May 2012, Alexander Shiyan wrote:
> > Modern CPUs from CLPS711X-line can operate at frequencies other than 73 MHz.
> > This patch adds calculation of system clock frequency and the frequency of
> > UART, depending on processor speed. Kconfig option "CPU frequency" was added
> > for this purposes.
...
> I think the right way to do this is to move the uart_add_one_port() call
> and the clps711x_ports array into platform code, so you can modify the
> frequency at boot time, but leave the uart_driver where it is.
> That will require some other changes for the console.
> 
> It's probably best to leave this patch for after the merge window, so you
> can come up with a good solution for 3.6, ok?
OK, Arnd, I'll think about the other implementation.
