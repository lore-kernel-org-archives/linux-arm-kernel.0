From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 23 May 2013 13:39:56 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCBWMiA0LzZdIEFSTTogZHRzOiBpbXg2cTogYWRkIHBp?=
 =?UTF-8?B?bmN0cmwgZm9yIFdFSU0gTk9S?=
In-Reply-To: <519DE109.1030903@freescale.com>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369300440.725629549@f101.mail.ru>
 <519DE109.1030903@freescale.com>
Message-ID: <1369301996.738631947@f310.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I suggest remove "nor" label here since it can be used for other devices later.
> this pinctrl is just for NOR.
> 
> If we attach other device to WEIM, it maybe needs other PAD, such as
> MX6Q_PAD_EIM_LBA__EIM_LBA_B. We need to add another pinctrl then.

How we should define CS1 pin in your example for second device?

---
