From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 19 Aug 2016 19:45:22 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBzYTExMDA6IGNsZWFyIHJlc2V0IHN0YXR1cyBw?=
 =?UTF-8?B?cmlvciB0byByZWJvb3Q=?=
In-Reply-To: <E1bamfG-0002WE-49@rmk-PC.armlinux.org.uk>
References: <E1bamfG-0002WE-49@rmk-PC.armlinux.org.uk>
Message-ID: <1471625122.822734676@f202.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>???????, 19 ??????? 2016, 19:29 +03:00 ?? Russell King <rmk+kernel@armlinux.org.uk>:
>
>Clear the current reset status prior to rebooting the platform.  This
>adds the bit missing from 04fef228fb00 ("[ARM] pxa: introduce
>reset_status and clear_reset_status for driver's usage").
>
>Signed-off-by: Russell King < rmk+kernel@armlinux.org.uk >
>---
...
>?static void assabet_lcd_backlight_power(int on)
>?{
>-if (on)
>+if (on && 0)
...
It looks like you did not remove the debugging code.

---
