From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Mar 2017 17:17:24 +0000
Subject: [PATCH v6 10/11] drivers: perf: hisi: use poll method when no
 IRQ for MN counter overflow
In-Reply-To: <1489127341-112908-1-git-send-email-anurup.m@huawei.com>
References: <1489127341-112908-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170321171724.GC29116@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 01:29:01AM -0500, Anurup M wrote:
> When no IRQ is supported in hardware, use hrtimer to poll and
> update event counter and avoid overflow condition for MN PMU.
> An interval of 8 seconds is used for the hrtimer.

Please fold this into the main MN patch.

The comments on the L3 hrtimer patch also apply here.

Thanks,
Mark.
