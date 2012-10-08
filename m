From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 14:10:02 -0700
Subject: [PATCH V2 0/7] ARM: OMAP2+: Add device-tree support for timers
In-Reply-To: <50661B07.1040200@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <505A7E0B.30709@ti.com> <20120920235309.GO28835@atomide.com>
 <5063330E.3000203@ti.com> <5065F19E.5020708@ti.com>
 <50661B07.1040200@ti.com>
Message-ID: <20121008211001.GH13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [120928 14:48]:
> 
> What is interesting is that it is the interrupt test that is failing for
> timers 5-7. Any chance there is a problem with the interrupt mapping? I
> checked the documentation for AM335x and I don't see anything obvious
> that is wrong with the binding unless the documentation itself is wrong.

This could also be caused by some timers not being able to wake up
the system from idle?

Regards,

Tony
