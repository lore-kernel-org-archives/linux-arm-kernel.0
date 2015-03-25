From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 25 Mar 2015 13:16:41 +0100
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150325113839.GD24636@arm.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <2694196.2XPpkm7uxF@vostro.rjw.lan> <20150325113839.GD24636@arm.com>
Message-ID: <2286147.A9elpz2VHW@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 25, 2015 11:38:43 AM Will Deacon wrote:
> On Wed, Mar 25, 2015 at 11:54:25AM +0000, Rafael J. Wysocki wrote:
> > On Wednesday, March 25, 2015 11:24:11 AM Will Deacon wrote:
> > > On Tue, Mar 24, 2015 at 10:02:53PM +0000, Grant Likely wrote:
> > > > On Thu, 19 Mar 2015 19:39:27 +0000 , Will Deacon <will.deacon@arm.com>
> > > > wrote:
> > > > > On Thu, Mar 19, 2015 at 10:17:27AM +0000, Lorenzo Pieralisi wrote:
> > > > > > Not only that, Sudeep has a patch to consolidate DT and ACPI SMP code,
> > > > > > I am working on it, I do not think it should be a blocking point, patch
> > > > > > coming asap on top of your series.
> > > > > 
> > > > > Well, I don't really want to merge the series without those patches so I
> > > > > do think it blocks the code from getting into mainline.
> > > > 
> > > > Really? It's a pretty minor duplication problem and it's been identified
> > > > as something requiring refactoring to both the ACPI and DT code. It
> > > > isn't at all dangerous. Why is this a blocking point?
> > > 
> > > Because I don't really see a valid excuse not to get this right first time
> > > around. Lorenzo already has patches on top, so we just need a co-ordinated
> > > review effort.
> > > 
> > > I wouldn't accept another patch series that needed minor rework (which by
> > > its very nature is easily addressed), so why should ACPI be treated any
> > > differently?
> > 
> > Not ACPI, but this particular patchset I think.  The problem is that it has
> > already been reviewed and ACKed by multiple people and it would be a shame
> > to require all of those people to do their reviews once again because of
> > that minor rework (which arguably can be done on top of the patchset just
> > fine).
> > 
> > Of course, if the minor rework in question would not involve the need to
> > review things once again, then I agree that it'd be better to do it upfront,
> > but otherwise there's a good reason not to.
> 
> Aha, I think this is just a misunderstanding -- I'm certainly not suggesting
> that Hanjun rework the current set! What I *am* asking for is that they go
> into mainline with Lorenzo's patches on top, which means that his series [1]
> needs some review (and I plan to look at it later today).

OK, that works for me, thanks for the clarification!

For the record, I've looked at the Lorenzo's series already and I don't see
anything particularly objectionable in it.

> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333257.html


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
