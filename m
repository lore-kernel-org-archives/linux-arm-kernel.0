From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 31 Aug 2010 12:25:08 +0100
Subject: [PATCH V2 0/4] Generalise ARM perf-events backend for oprofile
In-Reply-To: <20100831110517.GE22783@erda.amd.com>
References: <cover.1282848651.git.matt@console-pimps.org>
	<20100831110517.GE22783@erda.amd.com>
Message-ID: <20100831112508.GA27532@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 01:05:17PM +0200, Robert Richter wrote:
> On 26.08.10 15:09:15, Matt Fleming wrote:
> > The perf-events backend for OProfile that Will Deacon wrote in
> > 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
> > perf-events framework as backend") is of use to more architectures
> > than just ARM. Move the code into drivers/oprofile/ so that SH can use
> > it instead of the nearly identical copy of its OProfile code.
> > 
> > The benefit of the backend is that it becomes necessary to only
> > maintain one copy of the PMU accessor functions for each architecture,
> > with bug fixes and new features benefiting both OProfile and perf.
> > 
> > Note that I haven't been able to test these patches on an ARM board to
> > see if I've caused any regressions. If anyone else could do that I'd
> > appreciate it. Though, I have been able to compile this version of the
> > series.
> > 
> > This patch series is based on tip/master.
> 
> Matt,
> 
> please rebase your next version of this patch set to
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git core
> 
> It contains Will's patches.

Sure, will do! Thanks.
