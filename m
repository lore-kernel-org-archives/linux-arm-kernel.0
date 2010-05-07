From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 07 May 2010 10:12:39 -0700
Subject: MSM PMU Support in Commit ee3c454b
In-Reply-To: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
References: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
Message-ID: <1273252359.3542.21.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-07 at 18:02 +0100, Will Deacon wrote:
> Hi Russell,
> 
> Commit ee3c454b `arm: msm: add oprofile pmu support' in your devel
> branch adds an IRQ to the static list in kernel/pmu.c. Patch 6064/1 in
> the patch system replaces this old functionality with runtime registration
> using a platform device, so this commit prevents that patch applying.
> The OProfile patches in the system also depend on the runtime registration
> patch, so they will become blocked too.

Oh, sorry about that. I didn't realize a change like that was pending.
When are you planning to merge these changes?

> I can update the patch in the patch system so it applies cleanly, but
> the mach-msm bsp will need updating to register the IRQ using the new
> mechanism. Daniel: would you like me to submit a patch to do this, or
> would you rather do it [since I'm unfamiliar with the mach]?

Either, but your more motivated as it's blocking your progress ..

Daniel
