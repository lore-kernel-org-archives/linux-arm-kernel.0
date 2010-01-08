From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 08 Jan 2010 22:07:42 +0100
Subject: [PATCH] ixp4xx: implement sched_clock()
In-Reply-To: <19258.8144.467520.52849@pilspetsen.it.uu.se> (Mikael
	Pettersson's message of "Tue, 29 Dec 2009 16:27:12 +0100")
References: <19258.8144.467520.52849@pilspetsen.it.uu.se>
Message-ID: <m3vdfc9ug1.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> Add a better sched_clock() to the ixp4xx platform,
> implemented via its clocksource support.
>
> This is based on the sched_clock() I implemented for
> the IOP platform. Tested on a ds101 ixp420 machine.

Good to see the confirmation, I know next to nothing about the
clocksource matter. I can pick this up if you wish, of course,
or you can send it through Russell.
-- 
Krzysztof Halasa
