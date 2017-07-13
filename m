From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 13 Jul 2017 09:57:06 +0200
Subject: [patch] autogain support for bayer10 format (was Re: [patch]
 propagating controls in libv4l2)
In-Reply-To: <8a129dca-69c2-366f-1a81-c64dbabc1983@gmail.com>
References: <20170424093059.GA20427@amd> <20170424103802.00d3b554@vento.lan>
 <20170424212914.GA20780@amd> <20170424224724.5bb52382@vento.lan>
 <20170426105300.GA857@amd> <20170426081330.6ca10e42@vento.lan>
 <20170426132337.GA6482@amd>
 <cedfd68d-d0fe-6fa8-2676-b61f3ddda652@gmail.com>
 <20170426225150.GA4188@amd>
 <8a129dca-69c2-366f-1a81-c64dbabc1983@gmail.com>
Message-ID: <20170713075706.GB1363@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Oh, somehow I got confused that this is kernel code :)
> 
> >But I'd say NEON conversion is not neccessary anytime soon. First,
> >this is just trying to get average luminosity. We can easily skip
> >quite a lot of pixels, and still get reasonable answer.
> >
> >Second, omap3isp actually has a hardware block computing statistics
> >for us. We just don't use it for simplicity.
> >
> 
> Right, I forgot about that.
> 
> >(But if you want to play with camera, I'll get you patches; there's
> >ton of work to be done, both kernel and userspace :-).
> 
> Well, I saw a low hanging fruit I thought I can convert to NEON in a day or
> two, while having some rest from the huge "project" I am devoting all my
> spare time recently (rebasing hildon/maemo 5 on top of devuan Jessie).
> Still, if there is something relatively small to be done, just email me and
> I'll have a look.

Well, there's a ton of work on camera, and some work on
libcmtspeechdata. The later is rather self-contained.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170713/01ea4d01/attachment.sig>
