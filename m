From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Apr 2017 17:49:24 +0100
Subject: [PATCH 0/3] Add fault_major, fault_minor page fault trace events
In-Reply-To: <20170413022040.10156-1-credmonster@gmail.com>
References: <20170413022040.10156-1-credmonster@gmail.com>
Message-ID: <20170425164924.GR24484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 10:20:37PM -0400, Chris Redmon wrote:
> These changes add common trace events for major and minor page faults,
> as well as adding these traces to the arm and arm64 architectures. These
> traces offer useful information for determining the source of page faults
> in realtime systems, as well as the time penalty for taking a major or
> minor page fault.
> 
> I made an attempt to minimize the overhead when these tracepoints are not
> enabled, but I'm willing to make more changes if desired.

Why is this necessary, given that we already report these types of fault
as perf sw events?

Will
