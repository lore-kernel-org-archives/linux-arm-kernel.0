From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 8 Sep 2016 20:16:57 +0200
Subject: [RFCv4 0/7]  arm_pmu/perf tools: play nicely with CPU PMU cpumasks
In-Reply-To: <20160908162502.GB4801@kernel.org>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
 <20160908162502.GB4801@kernel.org>
Message-ID: <20160908181657.GX10153@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 01:25:02PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 08, 2016 at 11:21:45AM +0100, Mark Rutland escreveu:
> > Hi,
> > 
> > I'm trying to make the perf tool play better with PMUs in heterogeneous systems
> > (e.g. big.LITTLE), where there are several logical PMUs, each covering a subset
> > of CPUs.
> 
> So I added 6/7 and 7/7 to my local perf/core branch, I think they can go
> before the others, Peter, do you want me to take the kernel parts as
> well?

arm pmu stuff usually goes through the arm tree. Up to Mark I suppose.
