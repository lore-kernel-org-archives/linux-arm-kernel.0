From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 08 Jan 2014 13:04:57 +0400
Subject: =?UTF-8?B?UmU6IEluZm9ybWF0aW9uIGFib3V0IEF0bWVsIE1YVDIyNA==?=
In-Reply-To: <52CD04F1.8090100@gmail.com>
References: <52CD04F1.8090100@gmail.com>
Message-ID: <1389171897.588258801@f329.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????,  8 ?????? 2014, 8:57 +01:00 ?? Ga?tan Carlier <gcembed@gmail.com>:
> Hello,
> I have tried atmel_mxt_ts driver (original driver from kernel 3.6.0 and 
> driver from linux-next/master branch copied to kernel 3.6.0) on i.MX27 
> board. The capacitive glass used is a "GE Touch" 
> SMT-F-057G007-B011-4:3-NP. It has 16 pads in X and 14 pads in Y. It is 
> correctly detected (with one warning/error).
> The power supply of VDD and AVDD is 2.8V. AVDD will be raised later to 3.3V.
> When I push on glass, nothing occurs in evetst nor on /CHG pin of MXT224.

Do not forget about setup IOMUX for IRQ pin?

---
