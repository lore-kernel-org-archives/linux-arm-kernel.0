From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 08 Jul 2013 22:06:55 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzNdIEFSTTogbXgzOiBTZWxlY3QgQVJNX0VSUkFUQV80?=
 =?UTF-8?B?MTE5MjA=?=
In-Reply-To: <1373306318-15604-2-git-send-email-festevam@gmail.com>
References: <1373306318-15604-1-git-send-email-festevam@gmail.com>
 <1373306318-15604-2-git-send-email-festevam@gmail.com>
Message-ID: <1373306815.761097891@f229.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> ARM_ERRATA_411920 affects mx31 and mx35, so let's enable it:
> 
> ARM_ERRATA_411920:
> 	  Invalidation of the Instruction Cache operation can
> 	  fail. This erratum is present in 1136 (before r1p4), 1156 and 1176.
> 	  It does not affect the MPCore. This option enables the ARM Ltd.
> 	  recommended workaround.

IMHO, enabling any errata for multiplatform kernel is not a good idea.

---
