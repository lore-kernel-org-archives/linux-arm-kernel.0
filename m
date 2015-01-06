From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 6 Jan 2015 21:50:00 +0100
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <20150106202857.GB32308@saruman>
References: <20150106170433.GA5408@amd> <20150106172545.GK6502@saruman>
 <20150106175115.GA19487@amd> <20150106202857.GB32308@saruman>
Message-ID: <20150106205000.GB13902@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-01-06 14:28:57, Felipe Balbi wrote:
> On Tue, Jan 06, 2015 at 06:51:15PM +0100, Pavel Machek wrote:
> > 
> > On Tue 2015-01-06 11:25:45, Felipe Balbi wrote:
> > > On Tue, Jan 06, 2015 at 06:04:33PM +0100, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > In 3.18, sound is nice and clear.
> > > > 
> > > > In 3.19, sound is unusable. It produces nasty tone when it should be
> > > > quiet, and there's at least as much noise as is sound.
> > > > 
> > > > Unfortunately, list of mixers also changed (and there's cca 120
> > > > settings), but a) it does not work with the old list and b) nothing I
> > > > could figure out did make the sound usable. Some setting resulted in
> > > > even more noise.
> > > > 
> > > > Any idea what could have caused it?
> > > 
> > > $ git bisect start
> > > $ git bisect good v3.18
> > > $ git bisect bad
> > > 
> > > that'll help find what caused it.
> > 
> > Telling someone to do hard and time consuming job that probably will
> > not succeed, instead of actually providing help. Very very funny.
> 
> you're getting code for free, you're getting help for free. Not many
> people have N900s lying around. Running a bisection is just
> politeness.

Now you are speaking for yourself or for TI?

Thanks for your very valuable help. I know how to do a bisection,
thank you.
									Pavel
									
PS: Unfortunately, N900 will not boot using nfsroot in 3.16+ at least,
and boot from MMC card is broken and has been for quite some time.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
