From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 4 Jan 2017 11:37:13 +0100
Subject: [RFC PATCH 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <1483467027-14547-10-git-send-email-will.deacon@arm.com>
References: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
 <1483467027-14547-10-git-send-email-will.deacon@arm.com>
Message-ID: <20170104103713.GH25813@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 06:10:26PM +0000, Will Deacon wrote:
> The ARMv8.2 architecture introduces the Statistical Profiling Extension
> (SPE). SPE provides a way to configure and collect profiling samples
> from the CPU in the form of a trace buffer, which can be mapped directly
> into userspace using the perf AUX buffer infrastructure.
> 
> This patch adds support for SPE in the form of a new perf driver.
> 

Can you give a little high level overview of what exactly SPE is?
