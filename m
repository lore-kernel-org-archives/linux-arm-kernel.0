From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 3 Nov 2016 11:27:27 +0100
Subject: [PATCHv6] support for AD5820 camera auto-focus coil
In-Reply-To: <20160818202559.GF3182@valkosipuli.retiisi.org.uk>
References: <20160525212659.GK26360@valkosipuli.retiisi.org.uk>
 <20160527205140.GA26767@amd> <20160805102611.GA13116@amd>
 <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
 <20160808214132.GB2946@xo-6d-61-c0.localdomain>
 <20160810120105.GP3182@valkosipuli.retiisi.org.uk>
 <20160808232323.GC2946@xo-6d-61-c0.localdomain>
 <20160811111633.GR3182@valkosipuli.retiisi.org.uk>
 <20160818104539.GA7427@amd>
 <20160818202559.GF3182@valkosipuli.retiisi.org.uk>
Message-ID: <20161103102727.GA10084@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > > Yeah. I just compiled it but haven't tested it. I presume it'll work. :-)
> > > > 
> > > > I'm testing it on n900. I guess simpler hardware with ad5820 would be better for the
> > > > test...
> > > > 
> > > > What hardware do you have?
> > > 
> > > N900. What else could it be? :-) :-)
> > 
> > Heh. Basically anything is easier to develop for than n900 :-(.
> 
> Is it?
> 
> I actually find the old Nokia devices very practical. It's easy to boot your
> own kernel and things just work... until musb broke a bit recently. It
> requires reconnecting the usb cable again to function.
> 
> I have to admit I mostly use an N9.

Well, if you compare that to development on PC, I prefer PC.

Even arm development boards are usually easier, as they don't need too
complex userspace, and do have working serial ports.

But I do have a serial adapter for N900 now (thanks, sre), so my main
problem now is that N900 takes a lot of time to boot into usable
state.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/fd30267c/attachment.sig>
