From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Jan 2017 22:55:12 +0100
Subject: v4.9 to v4.10 regression: oops when USB cable is plugged in.
In-Reply-To: <20170124145127.GC7403@atomide.com>
References: <20170123222537.GA11543@amd> <20170123224454.GY7403@atomide.com>
 <20170124091817.GA29246@amd> <20170124100133.GA21079@pali>
 <20170124145127.GC7403@atomide.com>
Message-ID: <20170127215512.GG20571@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Can I get the copy of the patch?
> > > 
> > > http://www.spinics.net/lists/linux-usb/msg152542.html
> > > 
> > > ...but it is html mangled with no obvious way to unmangle it.
> 
> Bounced it to you. FYI, patchwork.kernel.org should have it too, the
> "mbox" option there works the best.

Thanks, applied. Problem did not reappear so far.

> > > > I was able to hit that only once so far, do you hit it
> > > > every time with your built-in g_ether .config?
> > > 
> > > I get it "way too often", like once a day. I don't yet know how to hit
> > > it reliably :-(.
> 
> OK, well let's hope the patch linked above fixes it. At some point the
> number of musb fixes should just start going down if I'm predicting right :)

Fingers crossed :-).

> Anyways, hitting these issues during late -rc cycle is too late. We
> really should have some n900 usability testing for core features with
> Linux next on at least weekly basis.

Ok, I can try. But so far even -rc1 is a lot of fun. But... I consider
phone calls core feature of a phone. I'd very much like to get that to
work. Unfortunately, that means real-time audio, and a lot of
fun. Plus, as it is touchscreen device, it needs a GUI. 

> I've noticed that testing with Linux next is way less effort than chasing
> bugs every -rc cycle when it's too late. For about past four months or so
> next has been usable for me with only occasional minor issues that get
> fixed within a day or two.

Well, I am carrying some patches... but maybe mainline is now good
enough to be useable without them?

No promises. I really should find more time for N900
development. Hmm. Or more developers. Where are all those Eudyptula
Challenge people when you need them?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/a1c3359f/attachment.sig>
