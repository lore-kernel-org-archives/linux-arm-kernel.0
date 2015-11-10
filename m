From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 10 Nov 2015 13:22:01 +0100
Subject: [PATCH v2 1/7] timekeeping: introduce __current_kernel_time64
In-Reply-To: <1447156675-7418-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <1447156675-7418-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20151110122201.GB17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 11:57:49AM +0000, Stefano Stabellini wrote:
> __current_kernel_time64 returns a struct timespec64, without taking the
> xtime lock. Mirrors __current_kernel_time/current_kernel_time.

It always helps if you include a reason why you want a patch.
