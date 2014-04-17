From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 17 Apr 2014 17:19:23 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIEFSTTogZHRzOiBpbXgyNy1wZGs6IEFkZCBOQU5E?=
 =?UTF-8?B?IHN1cHBvcnQ=?=
In-Reply-To: <CAOMZO5A6waVSFtaT=HobuBv=-4B7bAN_zwDd-W9JRaty6XGZug@mail.gmail.com>
References: <1397738561-3335-1-git-send-email-festevam@gmail.com>
 <1397739692.667087851@f420.i.mail.ru>
 <CAOMZO5A6waVSFtaT=HobuBv=-4B7bAN_zwDd-W9JRaty6XGZug@mail.gmail.com>
Message-ID: <1397740763.162588644@f90.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 17 Apr 2014 10:12:34 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Thu, Apr 17, 2014 at 10:01 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> 
> >> +&nfc {
> >> +     status = "okay";
> >> +     nand-ecc-mode = "hw";
> >> +     nand-on-flash-bbt;
> >> +};
> >
> > You also should add pin definitions.
> 
> NAND is detected even without the pin definitions.
> arch/arm/mach-imx/mach-mx27_3ds.c also does not define the NAND pins.

What if NFC pins are defined as GPIOs in the bootloader?
The definition of pins is a good idea, because we get a runtime
warning in case a possible conflict.

---
