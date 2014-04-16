From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 16 Apr 2014 15:58:46 +0400
Subject: =?UTF-8?B?UmU6IFVTQiBPVEcgc3VwcG9ydCBvbiBteDI3cGRr?=
In-Reply-To: <CAOMZO5Bgo8L1G2hpZpg=0uVdxkcDDnkOPkNGX9dHYk3Wq9J+=w@mail.gmail.com>
References: <CAOMZO5BcTP=fvYDE8EU2Y2Syn=QqbPd4zaQ96mSfy-mgLEjOmA@mail.gmail.com>
 <1397627716.685483508@f399.i.mail.ru>
 <CAOMZO5Bgo8L1G2hpZpg=0uVdxkcDDnkOPkNGX9dHYk3Wq9J+=w@mail.gmail.com>
Message-ID: <1397649526.601497269@f431.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 16 Apr 2014 08:32:55 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Wed, Apr 16, 2014 at 2:55 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> 
> > ci_hdrc ci_hdrc.0: EHCI Host Controller
> > ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
> > ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
> > usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> > usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> > usb usb1: Product: EHCI Host Controller
> > usb usb1: Manufacturer: Linux 3.15.0-rc1-next-20140415-dirty ehci_hcd
> > usb usb1: SerialNumber: ci_hdrc.0
> > hub 1-0:1.0: USB hub found
> > hub 1-0:1.0: 1 port detected
> 
> Thanks for testing, Alexander.
> 
> Does your bootloader have USB support?
> 
> If so, would it be possible to remove the USB support from the
> bootloader, please?
> 
> I am wondering if the bootloader is doing some USB related init that
> the kernel is missing.

I can tell immediately without further testing,
this will not work without the USB support in the bootoader because
we do not have DT support for ULPI.

---
