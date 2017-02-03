From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 3 Feb 2017 08:59:07 +0100
Subject: v4.9 to v4.10 regression: oops when USB cable is plugged in.
In-Reply-To: <20170127234832.cte4ki4ajwme2b2j@earth>
References: <20170123222537.GA11543@amd> <20170123224454.GY7403@atomide.com>
 <20170124091817.GA29246@amd> <20170124100133.GA21079@pali>
 <20170124145127.GC7403@atomide.com> <20170127215512.GG20571@amd>
 <20170127234832.cte4ki4ajwme2b2j@earth>
Message-ID: <20170203075907.GA21338@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Fri, Jan 27, 2017 at 10:55:12PM +0100, Pavel Machek wrote:
> > Ok, I can try. But so far even -rc1 is a lot of fun. But... I consider
> > phone calls core feature of a phone. I'd very much like to get that to
> > work. Unfortunately, that means real-time audio, and a lot of
> > fun. Plus, as it is touchscreen device, it needs a GUI. 
> 
> Talking about testing - kernelci's n900 is broken?
> 
> https://kernelci.org/boot/omap3-n900/

The N900 regressions are now more of "audio mixers no longer work"
than "it fails to boot" kind -- thus difficult to test automatically,
I'm afraid.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170203/a4e28c79/attachment.sig>
