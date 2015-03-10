From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 10 Mar 2015 16:44:10 +0100
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <20150310153608.GB31849@leverpostej>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
 <20150310112723.GY2896@worktop.programming.kicks-ass.net>
 <20150310120521.GD28168@leverpostej>
 <20150310125351.GD2896@worktop.programming.kicks-ass.net>
 <20150310153608.GB31849@leverpostej>
Message-ID: <20150310154410.GF2896@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 03:36:08PM +0000, Mark Rutland wrote:
> On the assumption that the patch is otherwise OK, how about the commit
> message below?

Yeah, that'll do fine. Thanks!
