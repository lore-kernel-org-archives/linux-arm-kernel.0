From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 11 Jul 2012 23:11:18 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAyLzNdIEFSTTogaS5NWDV4IGNsb2NrczogRml4IHBh?=
 =?UTF-8?B?cmVudCBmb3IgUFdNIGNsb2Nrcw==?=
In-Reply-To: <20120711065027.GG30009@pengutronix.de>
References: <20120709082700.GM24458@pengutronix.de>
 <1341946469-25984-2-git-send-email-shc_work@mail.ru>
 <20120711065027.GG30009@pengutronix.de>
Message-ID: <1342033878.36433466@f239.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Wed, 11 Jul 2012 08:50:27 +0200 ?? Sascha Hauer <s.hauer@pengutronix.de>:
On Tue, Jul 10, 2012 at 10:54:28PM +0400, Alexander Shiyan wrote:
> This patch also changes the names of the clocks to reflect the changes....
We should stick more closely to the clock names in the datasheet inside
the clock tree. Inside the clock tree the clock really is named 'hf'.
This makes matching the code with the datasheet easier.
So please resend this one with only the functional change included, no
renaming.OK. I'll post all three fixed patch in a new thread later.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120711/f2bfa3d8/attachment.html>
