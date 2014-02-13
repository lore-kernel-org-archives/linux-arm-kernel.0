From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 14:29:24 +0100
Subject: [PATCH v3 01/13] ARM: mvebu: rename armada-370-xp.c to
 armada-mvebu.c
In-Reply-To: <52FCC771.5090009@gmail.com>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392289475-8902-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <2036226.egxWL7qC66@wuerfel> <20140213125526.3af08c54@skate>
 <20140213130745.GU27395@titan.lakedaemon.net>
 <20140213141355.00e8f2fd@skate> <52FCC771.5090009@gmail.com>
Message-ID: <20140213142924.4520ccc9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Thu, 13 Feb 2014 14:24:01 +0100, Sebastian Hesselbarth wrote:

> > Why not. But since this kind of change can be done without breaking the
> > DT compatibility, I'd first prefer to see Dove support merged into
> > mach-mvebu/ with its board file named mach-mvebu/dove.c. Then
> > progressively see what can be combined with armada-mvebu.c so that we
> > can merge both of them into board-v7.c.
> 
> Actually, just prepared those patches today. Haven't boot tested but
> compiles cleanly. The patch set will be really small compared to KW
> patch set (but de-hardcoded pinctrl-dove will be a prerequisite).

Cool! I'm planning on giving a test to your pinctrl patches this
afternoon, if all goes well.

> I also prefer to move to mach-mvebu/dove.c and then merge with
> armada-3{78}{05x} a cycle later.

Yes, I agree. I'm fully convinced by the idea of merging the v7 support
together, but we need to proceed step by step to avoid having horrible
merge issues during the 3.15 cycle.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
