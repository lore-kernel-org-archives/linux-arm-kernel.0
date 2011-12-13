From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Dec 2011 21:16:41 +0000
Subject: [PATCH v4] ARM: sched_clock: allow sched_clock to be selected
 at runtime
In-Reply-To: <4EE7A03D.7060208@arm.com>
References: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com>
 <4EE57BC3.4080306@gmail.com> <4EE63459.1030105@arm.com>
 <20111213004656.GR32251@atomide.com> <20111213005018.GS32251@atomide.com>
 <CAH9JG2X9dGJVdwzs2Wbqt9_8=Lg1bsrDP_A0n-JDxgN3bAOYKg@mail.gmail.com>
 <4EE7A03D.7060208@arm.com>
Message-ID: <20111213211641.GC14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 06:58:05PM +0000, Marc Zyngier wrote:
> On 13/12/11 01:33, Kyungmin Park wrote:
> > Tested-by: Kyungmin Park <kyungmin,park@samsung.com>
> > 
> > On 12/13/11, Tony Lindgren <tony@atomide.com> wrote:
> >> * Tony Lindgren <tony@atomide.com> [111212 16:46]:
> >>> * Marc Zyngier <marc.zyngier@arm.com> [111212 08:33]:
> >>>>
> >>>> Queued as patch 7205/1.
> >>>>
> >>>> 	M.
> >>>
> >>> Great, seems to boot fine on all omaps I tried, will go ack it
> >>> in the patch system.
> >>
> >> Hmm I guess you can't comment patches there, so:
> >>
> >> Tested-by: Tony Lindgren <tony@atomide.com>
> 
> While I'm really glad to see platform maintainers testing and acking
> patches, may I kindly remind them to post their comments as early as
> possible?
> 
> This patch has been around since August, and has reached version 4
> before platform maintainers started to comment on it. Many platform
> specific patches are left unanswered (and no, I'm not the only one
> complaining).
> 
> So please, pretty please... When some platform-specific patch hit your
> mailbox, try to have a look at it in a timely manner. Specially if it is
> part of a much bigger series (by not answering, you're basically
> delaying the whole thing).

+1.

There's the matter that Samsung (and a few others) will be broken after
the next merge window because no one is putting any effort into sorting
it out for my restart changes.  This may be the last time I mention
this breakage.
