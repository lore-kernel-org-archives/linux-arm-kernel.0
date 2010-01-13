From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Wed, 13 Jan 2010 09:17:18 +0100
Subject: 21285 serial driver deadlock(?) fix
In-Reply-To: <20dd1d411001120912v3d8ec07aofa28282ff10accd8@mail.gmail.com>
References: <1262039226.28196.125.camel@localhost>
	<20100104091156.0f384dec@marrow.netinsight.se>
	<20dd1d411001051037o74fb1187j608889fae0271547@mail.gmail.com>
	<20100111105724.6a9f799c@marrow.netinsight.se>
	<20dd1d411001120912v3d8ec07aofa28282ff10accd8@mail.gmail.com>
Message-ID: <20100113091718.10b9a970@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jan 2010 20:12:36 +0300
Steve M <stevenm86@gmail.com> wrote:

> I was worried about the regular UART ops wanting a synced version, so I made
> a nonsynced version specifically to be called from the interrupt handler. I
> am attaching that patch for reference.

I'm fine with your patch as well as long as the board doesn't hang at
bootup :-).


Anyway, I belive mine was already applied to Russells git tree:

  http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5874/1

so I think you'd have to rebase your patch against that and submit it
to the ARM patch system.

// Simon
