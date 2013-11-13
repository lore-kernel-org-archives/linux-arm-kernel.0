From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Nov 2013 22:45:54 +0100
Subject: [linux-sunxi] [PATCH 2/2] ARM: sun6i: Add SMP support for the
 Allwinner A31
In-Reply-To: <1384188485.19117.90.camel@kazak.uk.xensource.com>
References: <1383471013-21695-1-git-send-email-maxime.ripard@free-electrons.com>
 <1383471013-21695-3-git-send-email-maxime.ripard@free-electrons.com>
 <1383583997.8826.123.camel@kazak.uk.xensource.com>
 <20131108084056.GB26440@lukather>
 <1383906355.3189.77.camel@kazak.uk.xensource.com>
 <20131110100312.GI26440@lukather>
 <1384188485.19117.90.camel@kazak.uk.xensource.com>
Message-ID: <20131113214554.GC3538@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 04:48:05PM +0000, Ian Campbell wrote:
> > > Anyway, once I get to the point of being able to do something I'll
> > > coordinate with Marc etc and figure out what to do. In the meantime I
> > > think having the kernel do the bringup (like this patch does) is
> > > sensible. It's very likely to be what we want to do in the absence of
> > > any instruction to the contrary (DTB or otherwise) in the future anyway.
> > 
> > Yep.
> > 
> > A part from the discussion on the approach, do you have any comments
> > on the patches themselves?
> 
> I know approximately diddly about how one is supposed to bring up these
> processors, but I did correlate what you were doing as best I could with
> the A20 manual for the registers and it looked sensible to me, modulo
> the fact that I was looking at the manual for a slightly different
> processor ;-)
> 
> Not a terribly strong statement, sorry.

Fair enough :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/d60f51a1/attachment.sig>
