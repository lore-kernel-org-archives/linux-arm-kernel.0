From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Thu, 5 Jul 2012 13:12:44 +0200 (CEST)
Subject: [PATCH 3 of 3] ARM: imx: add rtc support to mx35_3ds
In-Reply-To: <656646260.702972.1341412588384.JavaMail.root@advansee.com>
Message-ID: <181756671.768096.1341486764937.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Jul 4, 2012 at 04:36:28PM +0200, Beno?t Th?baudeau wrote:
> Now that RTC support has been enabled for i.MX35, add RTC to the
> mx35_3ds board.

I know that there is already the MC13XXXX providing the RTC feature on this
board, but:
 - it's possible to have several RTCs,
 - the purpose of the 3ds boards is to demonstrate the features of the i.MX
   platform, so it should do so with the mxc_rtc,
 - it can serve as a reminder to add mxc_rtc for i.MX35 when it will switch to
   device tree.

Regards,
Beno?t
