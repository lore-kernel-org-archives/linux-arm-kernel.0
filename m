From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 23 May 2013 13:55:06 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCBWMiA0LzZdIEFSTTogZHRzOiBpbXg2cTogYWRkIHBp?=
 =?UTF-8?B?bmN0cmwgZm9yIFdFSU0gTk9S?=
In-Reply-To: <519DE6D0.2040909@freescale.com>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369301996.738631947@f310.mail.ru>
 <519DE6D0.2040909@freescale.com>
Message-ID: <1369302906.444557883@f310.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > How we should define CS1 pin in your example for second device?
> 
> But in the imx6q{dl}-sabreauto boards, we only have the NOR connected to 
> WEIM.
> I do not need to worry about the second device.

OK, but you add "weim-NOR" to the arch/arm/boot/dts/imx6q.dtsi, not
in imx6qdl-sabreauto.dtsi, so you mean that this definition is generic.
Should it be moved to imx6qdl-sabreauto.dtsi then?

---
