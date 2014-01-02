From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Jan 2014 09:36:07 -0800
Subject: [BUG] shmobile build failure
In-Reply-To: <20140102172413.GB7383@n2100.arm.linux.org.uk>
References: <20140102172413.GB7383@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMiZrfP1GkdNqxKTUHHynMMH2i2x+1dwmZeuJ37CcaDOrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 2, 2014 at 9:24 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> allmodconfig and allyesconfig fail with this error:
>
> arch/arm/mach-shmobile/setup-rcar-gen2.c:21:32: fatal error: linux/clk/shmobile.h: No such file or directory
>
> My guess is that shmobile on its own doesn't build because of this.
> Is there a screwed dependency between arm-soc and the clk git trees?

Yeah, I noticed this too but hadn't had a chance to report it yet --
holidays followed by getting sick.

I'm guessing they have a dependency on clk rework that we haven't merged.

Simon?

-Olof
