From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 19 Jul 2012 04:56:06 +0000
Subject: [PATCH 1/1] Add Wondermedia Technologies (wmt) to
 docs/devicetree/vendor-bindings.txt
In-Reply-To: <CABjd4Yyk6XR6RizgcpjCdi2N_+Z2EzTtezbkN9V7r4bAXXjhqA@mail.gmail.com>
References: <76F764B079F92A4E843589C893D0A022C380F1D4@SERVER.prisktech.co.nz>
 <201207171250.32265.arnd@arndb.de>
 <CABjd4Yyk6XR6RizgcpjCdi2N_+Z2EzTtezbkN9V7r4bAXXjhqA@mail.gmail.com>
Message-ID: <76F764B079F92A4E843589C893D0A022C381059B@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given that there have been no replies to this thread, and the restart patch has
now been accepted using 'wmt' as the vendor namespace - would it be safe to
assume we should formalize this in the vendor-bindings.txt?

I'd like to try and have basic device tree support added for the next merge
window (or this one if it all goes well :) ), but it relies on the vendor binding being
formalized.

Regards,

Tony P

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Alexey
> Charkov
> Sent: Wednesday, 18 July 2012 1:31 a.m.
> To: vt8500-wm8505-linux-kernel at googlegroups.com
> Cc: Tony Prisk; devicetree-discuss at lists.ozlabs.org; Russell King; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] Add Wondermedia Technologies (wmt) to docs/devicetree/vendor-bindings.txt
> 
> 2012/7/17 Arnd Bergmann <arnd@arndb.de>:
> > It would also be helpful to describe why the specific string is used here.
> > Normally we use the stock ticker symbol and "wmt" refers to Wal-Mart,
> > which would be unlikely but not impossible to produce their own hardware
> > in the future. The same thing applies to "via", which is VIACOM. The symbol
> > for VIA technologies is "2388.TW", but that is not particularly descriptive
> > or well-known.
> >
> > Maybe someone on the devicetree-discuss mailing list has a better
> > suggestion. I think using "via" is probably the best compromise, as
> > it's a well-known name and most of the components of the wondermedia
> > chips were first made by VIA anyway.
> 
> In fact, "wmt" is the name that the vendor itself uses in their GPL
> code (they also use mach-wmt as the arch-specific folder name). I
> believe that we could just as well use the full "wondermedia" word to
> avoid possible confusion, in case "wmt" is unacceptable for any
> reason.
> 
> Best,
> Alexey
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
