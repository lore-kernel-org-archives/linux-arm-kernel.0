From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 22:10:29 +0100
Subject: [linux-sunxi] Re: [PATCH v2 4/9] arm: dts: sun8i: split
 Allwinner H3 .dtsi
In-Reply-To: <20170127190239.2MQaUuKh@smtp2o.mail.yandex.net>
References: <20170127190239.2MQaUuKh@smtp2o.mail.yandex.net>
Message-ID: <20170127211029.k5ylfhrreqfdn2iz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 12:02:20AM +0800, Icenowy Zheng wrote:
> 
> 2017?1?27? 23:55? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Thu, Jan 26, 2017 at 11:48:54PM +0800, Icenowy Zheng wrote: 
> > > - mmc0: mmc at 01c0f000 { 
> > > + mmc at 01c0f000 { 
> >
> > There's no point in removing the labels, and you can even use the 
> > label-based syntax to reference them, instead of using the path. 
> 
> I think keeping a tree structure in sub dtsi file will make it more
> pretty and easy to use :-)

We're already using that syntax for all the DTS, so it won't be less
pretty than those.

And keeping a tree structure valid is not easier to use than, well,
not having to keep it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/ae35c7ca/attachment.sig>
