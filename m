From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Jul 2013 09:20:59 +0200
Subject: [PATCH 00/10] Orion Watchdog fixes
In-Reply-To: <20130716065952.GA25043@lunn.ch>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch>
Message-ID: <20130716092059.237ea729@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 16 Jul 2013 08:59:52 +0200, Andrew Lunn wrote:

> Maybe i'm missing something here. You are making use of
> orion_timer_ctrl_clrset() from time-orion.c. How will this work on
> 370/XP which has a different clocksource driver?

I *think* the idea is that the Armada 370/XP driver will expose the
same function, so from the point of view of the watchdog driver, it
will just work. This set of patches is just some preparation patches on
the Orion watchdog driver, to later make it usable on Armada 370/XP.
The patches enabling its usage on Armada 370/XP will follow.

But Ezequiel will confirm all that, we had a discussion together about
this yesterday, so I guess what I said should be the plan, but it's
better if Ezequiel confirms, obviously :)

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
