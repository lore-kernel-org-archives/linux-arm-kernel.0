From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Fri, 11 Mar 2016 17:56:12 +0100 (CET)
Subject: [OpenWrt-Devel] ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <3cbff06f821f529e67cf75580ee89732@advem.lv>
References: <201603101013.04618.arnd@arndb.de>
 <alpine.LNX.2.00.1603110638190.12310@T520.work>
 <56E26A47.9040608@openwrt.org> <3cbff06f821f529e67cf75580ee89732@advem.lv>
Message-ID: <alpine.LNX.2.00.1603111721340.13469@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI

On Fri, 11 Mar 2016, Roman Yeryomin wrote:

> On 2016-03-11 08:48, John Crispin wrote:
> > On 11/03/2016 06:44, Hans Ulli Kroll wrote:
> > > Hi
> > > > 
> > > > * Gemini: officially supported in OpenWRT today, with the latest
> > > > compiler. This one
> > > >   will likely cause the most issues for actual users. It would be
> > > > helpful to get
> > > >   some numbers about users or downloads here, to see whether it can be
> > > > dropped
> > > >   in a future OpenWRT release or if it might be possible to leave this
> > > > on
> > > >   gcc-6.x when the other platforms move on to gcc-7+
> > > 
> > > I don't have any numbers from the OPenWRT people.
> > > For the NAS BOXes itself, I get one/two support questions a month on the
> > > german based forum.
> > > I think most people know about the SATA bug, which makes the platform
> > > unreliable for some SATA drives.
> > > y
> > > Hans Ulli
> > 
> > Hi,
> > 
> > We have several active users. Roman has done a great job to constantly
> > maintain and update the target. We have been including gemini in our
> > releases for years thanks to Romans effort. It would be a shame to to
> > see support being dropped, even if there are few yet active users.
> >
> 
> Thanks, John.
> I'm actively using it as a backup box and know at least several other people.
> Although it's quite old I can't stop using it, it serves well for me and I
> don't see any reason to throw it out.
> I've heard of SATA problems but never seen them myself.

The SATA bug occurs first on Samsung devices. 
I bought a HDD to test this by my self and check if it's possible to fix. 
There are some 'hidden' registers to tweak to PATA controller, the 
names can be found in the PATA header from the original sources.
No avail !
So I asked Paulius sometime ago about this and the PATA/SATA mux, he has 
also no clue for fixing this.

> As to the numbers I think that people like me (or others trying out OpenWrt)
> usually don't go to the forums, so number of questions there doesn't tell much
> (but even there latest messages are from last month, so not dead at all).
> Maybe number of downloads from downloads.openwrt.org can tell more but I would
> guess that actual users would rather compile it themselves.

The support thread on the german board is very long, so most of the 
questions are answered there. The experienced don't need this, so the 
numbers *are* wrong.

And I'm using two of the NAS boxes for backup and another for kernel work

> So I vote for not killing it at least until it's supported by kernel.
> 

ACK !!

Hans Ulli
