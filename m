From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 05 Jun 2013 13:19:12 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAxLzJdIGh3bW9uOiBtYzEzNzgzLWFkYzogUmVmYWN0?=
 =?UTF-8?B?b3Igc291cmNlIHRvIGluZGljYXRlIHZhcmlvdXMgbWMxM3h4eCBjaGlwcw==?=
In-Reply-To: <20130605110206.02fc09f3@endymion.delvare>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
 <20130605110206.02fc09f3@endymion.delvare>
Message-ID: <1370423952.906453652@f168.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed,  5 Jun 2013 12:57:07 +0400, Alexander Shiyan wrote:
> > This patch renames structures, variables and functions to indicate support
> > for various MC13xxx chips.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  drivers/hwmon/mc13783-adc.c | 135 +++++++++++++++++++++-----------------------
> >  1 file changed, 63 insertions(+), 72 deletions(-)
> 
> Nack. This change serves absolutely no purpose, all it's doing it make
> everyone's life harder. Just don't do that, thanks.

I do not understand stubbornness here.
The driver works for different chips, it should be reflected in the code.

---
