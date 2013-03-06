From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Mar 2013 18:37:51 +0000
Subject: ARM: 7653/2: do not scale loops_per_jiffy when using a
 constant delay clock
In-Reply-To: <20130306022308.GA21539@mudshark.cambridge.arm.com>
References: <20130306022308.GA21539@mudshark.cambridge.arm.com>
Message-ID: <20130306183751.GV17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 02:23:08AM +0000, Will Deacon wrote:
> I notice that commit 70264367a243 ("ARM: 7653/2: do not scale loops_per_jiffy
> when using a constant delay clock") is in mainline, but I'm not sure whether
> it's the right fix. Unfortunately, I failed to find it in the list archives,
> so I couldn't repy to the original patch.

Sigh.  Here we go again.  I've said this many times.  Patches need to be
sent to the mailing list *before* they're sent to the patch system.  Not
just the complex ones.  ALL PATCHES including those which look like simple
fixes.

The reason being is that if someone wants to comment on the patch, they
can.  For exactly the kind of reason that Will brings up above.  You may
think your fix is obvious and the right solution, but someone else in this
complex ecosystem may have a case where your otherwise perfect solution
doesn't work.
