From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Mon, 17 Feb 2014 08:08:57 +0100
Subject: [linux-sunxi] [PATCH v6 4/8] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
In-Reply-To: <1392542548.11093.13.camel@chi.lan>
References: <20140216050933.728.25526.stgit@dizzy-6.o2s.ch>
 <20140216051133.728.36386.stgit@dizzy-6.o2s.ch>
 <1392542548.11093.13.camel@chi.lan>
Message-ID: <1744603.zMUgfmoUUP@pagira.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> > + * Driver for sunxi SD/MMC host controllers
> > + * (C) Copyright 2014-2015 Reuuimlla Technology Co., Ltd.
> > + * (C) Copyright 2014-2015 Aaron Maoye <leafy.myeh@reuuimllatech.com>
> > + * (C) Copyright 2014-2015 O2S GmbH <www.o2s.ch>
> > + * (C) Copyright 2014-2015 David Lanzend?rfer
> > <david.lanzendoerfer@o2s.ch>
> > + * (C) Copyright 2014-2015 Hans de Goede <hdegoede@redhat.com>
> ETIMETRAVEL
I'm not really into this licensing and copyright stuff.
Could you maybe point out what the correct copyright would be?

> __SUNXI_MMC_H__
Ok. Will fix that.

> Also, you may want to rename SDXC_RESPONSE_* to SDXC_RESP_*, which looks
> better next to the SDXC_DATA_* defines...
Ok. I will change that :-)

-david
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140217/1faf4b9f/attachment.sig>
