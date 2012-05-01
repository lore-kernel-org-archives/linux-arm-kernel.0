From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 1 May 2012 10:48:29 +0200
Subject: [PATCH] maintainership update for the Marvell Orion family of SOCs
In-Reply-To: <201204302217.35958.arnd@arndb.de>
References: <alpine.LFD.2.02.1204301330111.21030@xanadu.home>
 <201204302124.28892.arnd@arndb.de>
 <87mx5sanuf.fsf@lebrac.rtp-net.org>
 <201204302217.35958.arnd@arndb.de>
Message-ID: <20120501084829.GF15541@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Well, there is no reason to rush this at all, it could live in parallel
> for a couple of years. But at one point we can decide that if nobody has
> bothered to write the .dts file for one board and tested it that nobody
> cares about that board any more and it can just get removed and possibly
> added back in dts form when someone does complain.

Probably a FAQ, but maybe somebody can point me in the right
direction. How will Debian, Ubuntu, etc, deal with old machines who's
u-boot does not support DT, yet the kernel has moved on and only has
DT support for a board? Will the kernel install process need to
determine what board the machine is and append the DT to the end of
the kernel? Or do we envisage a process where all DT are appended to
the kernel, and the machine ID, as passed by the old uboot, is used to
pick the correct DT?

    Thanks
	Andrew
