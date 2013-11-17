From: Peter.Chen@freescale.com (Peter Chen)
Date: Sun, 17 Nov 2013 04:52:42 +0000
Subject: [PATCH 2/2] usb: chipidea: usbmisc: Add support for i.MX51 CPU
In-Reply-To: <1384609562.504234110@f348.i.mail.ru>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <CAHCPf3tOxKESwbooR0sz0w=A8n6uEDOmaawDxick0+AMBRAQfA@mail.gmail.com>
 <F281D0F91ED19E4D8E63A7504E8A64980411A0C0@039-SN2MPN1-021.039d.mgd.msft.net>
 <1384609562.504234110@f348.i.mail.ru>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A64980411A277@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > > This gives us some breathing room later to actually do the right
> thing
> > > without additionally performing renames all over the place to make
> > > imx5 -> imx53 (again)/imx51 (new).
> >
> > You may take matt's suggestion, it can reduce the code change now and
> in future.
> > We can only add device_id for imx51 in this patch, split imx53 and
> imx51's ops
> > when their differences are added in future.
> 
> OK. Names of registers and bits also keep as is?
> 

Yes.

Peter
