From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 23 Dec 2013 12:24:13 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdmlkZW86IGlteGZiOiBVc2UgcmVndWxhdG9yIEFQSSB3?=
 =?UTF-8?B?aXRoIExDRCBjbGFzcyBmb3IgcG93ZXJpbmc=?=
In-Reply-To: <20131223082107.GF26070@S2101-09.ap.freescale.net>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
 <20131223082107.GF26070@S2101-09.ap.freescale.net>
Message-ID: <1387787053.605757144@f413.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Dec 21, 2013 at 03:08:00PM +0400, Alexander Shiyan wrote:
> > This patch replaces custom lcd_power() callback with
> > regulator API over LCD class.
> 
> FYI.  Denis' effort on this already goes to v13.
> 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/285326

Hmm, OK, but having LCD class could resolve our problems with contrast control.
https://www.mail-archive.com/devicetree at vger.kernel.org/msg07660.html

---
