From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Thu, 14 Jun 2012 14:24:31 +0530
Subject: Fwd: [RFC PATCH 00/15] ARM: perf: support multiple PMUs
In-Reply-To: <20120613170214.GD11458@mudshark.cambridge.arm.com>
References: <4B9A4BAF850C914D8DED94776A2C477E0B853A2F@nasanexd01b.na.qualcomm.com>
 <4E52A852.9090809@codeaurora.org>
 <20110822201546.GD22755@e102144-lin.cambridge.arm.com>
 <CAMzctLkwJCrgKoeYET=OYcfOifKuTEWoWfcRgWts4Y6aspZEUA@mail.gmail.com>
 <20120613114326.GA14399@bnru02>
 <20120613170214.GD11458@mudshark.cambridge.arm.com>
Message-ID: <20120614085430.GA28552@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 19:02:14 +0200, Will Deacon wrote:
> On Wed, Jun 13, 2012 at 12:43:27PM +0100, Srinidhi Kasagar wrote:
> > > The series is based on Will Deacon's perf-updates branch at:
> > >        git://linux-arm.org/linux-2.6-wd.git perf-updates
> > > 
> > > An example driver using the framework (supporting the PMU present in
> > > L220/PL310 level 2 cache controllers) can be found at:
> > >        git://linux-arm.org/linux-2.6-wd.git perf-l2x0-wip
> > > 
> > Do you still maintain this tree? Looks it is empty. I'm wondering if
> > we can make use of this to instrument the PMU counters of L2/pl310.
> 
> There's an old branch here, but this stuff is pretty bit-rotted and needs
> reworking as part of the big.LITTLE support:
> 
> http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=shortlog;h=refs/heads/perf/l2x0

Thanks, will look at it.

/srinidhi
