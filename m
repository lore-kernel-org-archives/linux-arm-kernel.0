From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 22:17:35 +0000
Subject: [PATCH] maintainership update for the Marvell Orion family of SOCs
In-Reply-To: <87mx5sanuf.fsf@lebrac.rtp-net.org>
References: <alpine.LFD.2.02.1204301330111.21030@xanadu.home>
 <201204302124.28892.arnd@arndb.de> <87mx5sanuf.fsf@lebrac.rtp-net.org>
Message-ID: <201204302217.35958.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 April 2012, Arnaud Patard wrote:
> > the plat-orion directory and leave the other directories for the classic
> > probing, eventually to be removed when the new stuff can handle all the
> > machines that someone cares about.
> 
> I'm not sure we'll be able to remove any machine without being sure it's
> working and it can take quite some time. orion/kirkwood/... are used on
> NAS boxes so I guess people are not necessary updating their kernel on a
> regular basis.

Well, there is no reason to rush this at all, it could live in parallel
for a couple of years. But at one point we can decide that if nobody has
bothered to write the .dts file for one board and tested it that nobody
cares about that board any more and it can just get removed and possibly
added back in dts form when someone does complain.

	Arnd
