From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Nov 2016 19:34:46 +0000
Subject: ath9k ARMv7 OOPS in v4.8.6, v4.2.8
In-Reply-To: <87a8cqgfpp.fsf@kamboji.qca.qualcomm.com>
References: <20161123191539.GF2799@io.lakedaemon.net>
 <87a8cqgfpp.fsf@kamboji.qca.qualcomm.com>
Message-ID: <20161123193446.GG2799@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kalle,

On Wed, Nov 23, 2016 at 09:26:42PM +0200, Kalle Valo wrote:
> Jason Cooper <jason@lakedaemon.net> writes:
> > I have a Ubiquiti SR-71 mini-pcie ath9k card in a Globalscale Mirabox
> > board (Marvell Armada 370 SoC).  Every day or so I get a consistent
> > crash that brings down the whole board.  I've attached three oops I
> > captured on the serial port.
> >
> > I looked at the commits from v4.8.6 to v4.9-rc6, and nothing jumped out
> > at me as "this would fix it".  And since it takes a day or so to trigger
> > the oops, bisecting would be a bit brutal.  Does anyone have any insight
> > into this?
> 
> Is this a regression, meaning that it didn't crash on older kernels but
> crashes on newer ones? Or has it always crashed?

iirc, it's always done this.  It's one of my spare wifi backhauls that
spends most of it's time in a cardboard box waiting for a task,
collecting dust.  Kinda like the toys in Toy Story.

I pulled it out a month or so ago and the behavior started.  It had
4.2.8 on it at the time.  I upgraded to latest stable a few weeks ago
(v4.8.6) and I'm getting the same issue.

When I originally set it up, it didn't run long enough for me to recall
if the issue occurred.  Best I recall, that was with v4.2.8.

thx,

Jason.
