From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2011 14:45:35 +0000
Subject: Error for machine_is_m28evk
In-Reply-To: <20111108140557.GC10538@mudshark.cambridge.arm.com>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
 <4EB8CC7B.5060503@denx.de> <20111108075349.GK2854@pengutronix.de>
 <CAB4PhKeKdGLa74W-n1DNbUcszWMf3nymqqhuzdZoj_oQG+YNsg@mail.gmail.com>
 <20111108085350.GX12913@n2100.arm.linux.org.uk>
 <20111108125346.GA7563@S2100-06.ap.freescale.net>
 <20111108133744.GE12913@n2100.arm.linux.org.uk>
 <20111108140557.GC10538@mudshark.cambridge.arm.com>
Message-ID: <20111108144535.GF12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 02:05:58PM +0000, Will Deacon wrote:
> On Tue, Nov 08, 2011 at 01:37:44PM +0000, Russell King - ARM Linux wrote:
> > (b) with the loss of facilities like kautobuild (no one noticed for six
> >     months that simtec had shut it down...), we have lost any kind of
> >     automated detection for these kinds of issues.
> 
> Have Simtec /actually/ shut this down, or did it just die when kernel.org
> was hacked and nobody has poked it since then?

I talked to Vince yesterday - it was shut down at the end of May,
before the kernel.org problem.  Apparantly, it was announced on the
kautobuild mailing list and there was no reaction to that either.

As I understand it, it become uneconomic to continue with the effort,
both on terms of running the backend (Vince used to run that himself)
or in terms of developing a replacement (a clustered build farm.)

Given that no one noticed that it had been shut down, that reinforced
the point that it wasn't a useful exercise to have running (because,
if it was, people would've noticed it wasn't updating and would've said
something.)
