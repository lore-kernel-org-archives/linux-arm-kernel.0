From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 19 Jan 2017 16:41:28 +0100
Subject: [linux-sunxi] Re: [PATCH v2 2/4] clk: sunxi-ng: add support for
 V3s CCU
In-Reply-To: <20170117200213.27eGY8hi@smtp3h.mail.yandex.net>
References: <20170117200213.27eGY8hi@smtp3h.mail.yandex.net>
Message-ID: <20170119154128.hzhggymgg7uczpfo@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 01:02:03AM +0800, Icenowy Zheng wrote:
> 
> 2017?1?17? 17:04? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > Hi, 
> >
> > On Tue, Jan 17, 2017 at 02:01:14AM +0800, Icenowy Zheng wrote: 
> > > V3s has a similar but cut-down CCU to H3. 
> > > 
> > > Add support for it. 
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> > > --- 
> >
> > Output from checkpatch: 
> > total: 5 errors, 2 warnings, 3 checks, 857 lines checked 
> >
> > > I think I should make a comparsion between V3s and H3 CCU here: 
> > > (I won't mention the missing/added clocks here, only list conflicting clocks) 
> >
> > That should be in your commit log. 
> 
> I think it can be easily get by a diff command :-)
> 
> And we do not have the tradition to describe clock difference in
> commit log, is it right?

In very low details, no, but still having the big picture is a good
idea.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/799557e0/attachment-0001.sig>
