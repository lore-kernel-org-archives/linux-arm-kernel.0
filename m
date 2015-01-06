From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Jan 2015 14:54:13 -0600
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <20150106205000.GB13902@amd>
References: <20150106170433.GA5408@amd> <20150106172545.GK6502@saruman>
 <20150106175115.GA19487@amd> <20150106202857.GB32308@saruman>
 <20150106205000.GB13902@amd>
Message-ID: <20150106205413.GF32308@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 06, 2015 at 09:50:00PM +0100, Pavel Machek wrote:
> On Tue 2015-01-06 14:28:57, Felipe Balbi wrote:
> > On Tue, Jan 06, 2015 at 06:51:15PM +0100, Pavel Machek wrote:
> > > 
> > > On Tue 2015-01-06 11:25:45, Felipe Balbi wrote:
> > > > On Tue, Jan 06, 2015 at 06:04:33PM +0100, Pavel Machek wrote:
> > > > > Hi!
> > > > > 
> > > > > In 3.18, sound is nice and clear.
> > > > > 
> > > > > In 3.19, sound is unusable. It produces nasty tone when it should be
> > > > > quiet, and there's at least as much noise as is sound.
> > > > > 
> > > > > Unfortunately, list of mixers also changed (and there's cca 120
> > > > > settings), but a) it does not work with the old list and b) nothing I
> > > > > could figure out did make the sound usable. Some setting resulted in
> > > > > even more noise.
> > > > > 
> > > > > Any idea what could have caused it?
> > > > 
> > > > $ git bisect start
> > > > $ git bisect good v3.18
> > > > $ git bisect bad
> > > > 
> > > > that'll help find what caused it.
> > > 
> > > Telling someone to do hard and time consuming job that probably will
> > > not succeed, instead of actually providing help. Very very funny.
> > 
> > you're getting code for free, you're getting help for free. Not many
> > people have N900s lying around. Running a bisection is just
> > politeness.
> 
> Now you are speaking for yourself or for TI?

why bring my employer into the discussion ?

> Thanks for your very valuable help. I know how to do a bisection,
> thank you.

then please do it.

> PS: Unfortunately, N900 will not boot using nfsroot in 3.16+ at least,
> and boot from MMC card is broken and has been for quite some time.

Then how do you know it changed from v3.18 to v3.19-rc ? Certainly you
ran v3.18 on N900 to verify that audio quality was better with that
kernel. Use the very same method during bisection.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/86bca815/attachment.sig>
