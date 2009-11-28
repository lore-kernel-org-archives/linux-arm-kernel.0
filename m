From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Nov 2009 18:09:53 +0000
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <alpine.LFD.2.00.0911281140080.5388@xanadu.home>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<FCBE654890C0334289D0AD3AF4EF009F89684D7F09@IL-MB01.marvell.com>
	<20091127200521.GC28193@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911271547110.2059@xanadu.home>
	<c70ff3ad0911280004y5a78bed2ndc134c2a7e8b4382@mail.gmail.com>
	<alpine.LFD.2.00.0911281140080.5388@xanadu.home>
Message-ID: <20091128180953.GA497@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 11:41:39AM -0500, Nicolas Pitre wrote:
> On Sat, 28 Nov 2009, saeed bishara wrote:
> 
> > The board id that supported by this patch is 1788, the board name in
> > the machines registry updated to dove_db, but the Type Identifier
> > needs to be changed from MACH_TYPE_MACH_MARVELL_NEW1 to
> > MACH_TYPE_DOVE_DB.
> 
> The orion repo has the right machine identifier already. No changes 
> needed there.

Meanwhile, I've been deleting it from my updates to mainline ever since it
was created back in 2008 because it looked like someone screwed up their
entry, and registered 1789 instead of talking to me.

This means if I pull the dovedb stuff into mainline now, it's probably
going to break builds.

Since I've only just updated the mach-types file in mainline this week,
I'm not happy about adding it in, especially as the current update is
still outstanding for Linus.

A little bit of communication goes a long way...
