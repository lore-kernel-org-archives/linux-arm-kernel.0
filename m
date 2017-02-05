From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 5 Feb 2017 22:44:13 +0100
Subject: v4.9 to v4.10 regression: oops when USB cable is plugged in.
In-Reply-To: <20170203163048.GA3721@atomide.com>
References: <20170123222537.GA11543@amd> <20170123224454.GY7403@atomide.com>
 <20170124091817.GA29246@amd> <20170124100133.GA21079@pali>
 <20170124145127.GC7403@atomide.com> <20170127215512.GG20571@amd>
 <20170127234832.cte4ki4ajwme2b2j@earth>
 <20170203075907.GA21338@amd> <20170203163048.GA3721@atomide.com>
Message-ID: <20170205214413.GA7573@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-02-03 08:30:48, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [170203 00:00]:
> > Hi!
> > 
> > > On Fri, Jan 27, 2017 at 10:55:12PM +0100, Pavel Machek wrote:
> > > > Ok, I can try. But so far even -rc1 is a lot of fun. But... I consider
> > > > phone calls core feature of a phone. I'd very much like to get that to
> > > > work. Unfortunately, that means real-time audio, and a lot of
> > > > fun. Plus, as it is touchscreen device, it needs a GUI. 
> > > 
> > > Talking about testing - kernelci's n900 is broken?
> > > 
> > > https://kernelci.org/boot/omap3-n900/
> > 
> > The N900 regressions are now more of "audio mixers no longer work"
> > than "it fails to boot" kind -- thus difficult to test automatically,
> > I'm afraid.
> 
> Talking about audio testing, next now has commit 9834ffd1ecc3
> ("ASoC: omap-mcbsp: Add PM QoS support for McBSP to prevent glitches"),
> care to check if that also fixes the n900 audio glitch issues you
> reported earlier?

Yes, audio was choppy when I tried to use n900 as an mp3
player. Hmm. I re-checked v4.9, and it seems to work ok now. I'll
speak up if it re-appears.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170205/0f898b35/attachment.sig>
