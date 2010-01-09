From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 9 Jan 2010 12:30:15 +0100
Subject: [PATCH] ixp4xx: implement sched_clock()
In-Reply-To: <m3vdfc9ug1.fsf@intrepid.localdomain>
References: <19258.8144.467520.52849@pilspetsen.it.uu.se>
	<m3vdfc9ug1.fsf@intrepid.localdomain>
Message-ID: <19272.26823.223723.604765@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Halasa writes:
 > Mikael Pettersson <mikpe@it.uu.se> writes:
 > 
 > > Add a better sched_clock() to the ixp4xx platform,
 > > implemented via its clocksource support.
 > >
 > > This is based on the sched_clock() I implemented for
 > > the IOP platform. Tested on a ds101 ixp420 machine.
 > 
 > Good to see the confirmation, I know next to nothing about the
 > clocksource matter. I can pick this up if you wish, of course,
 > or you can send it through Russell.

I'll send it to the patch system later today.

/Mikael
