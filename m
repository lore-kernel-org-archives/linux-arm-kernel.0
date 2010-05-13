From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 13 May 2010 05:25:45 +0100
Subject: S5PC100 planning
Message-ID: <20100513042545.GT6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I would like to get an idea of what each group involvedi n the
current S5PC100 changes is planning to allow the organisation of
what is going on.

Firstly, I think Kukjin's clock changes are the first to be
applied, followed by looking at what support exists (or is being
submitted) in plat-s5p which could be used for s5pc100.

Then, let's move out what is left of plat-s5pc1xx into mach-s5pc100
and get rid of it (although the final removal may have to be left
until the next merge window, due to time constraints).

I would like to see whatever changes done grouped into sections,
such as clock, machine, core, gpio.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
