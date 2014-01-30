From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 30 Jan 2014 10:28:35 +0100
Subject: [PATCH v2 0/6] setting the table for integration of cpuidle with
 the scheduler
In-Reply-To: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20140130092835.GL11314@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 12:45:07PM -0500, Nicolas Pitre wrote:
> As everyone should know by now, we want to integrate the cpuidle
> governor with the scheduler for a more efficient idling of CPUs.
> In order to help the transition, this small patch series moves the
> existing interaction with cpuidle from architecture code to generic
> core code.  The ARM, PPC, SH and X86 architectures are concerned.
> No functional change should have occurred yet.
> 
> @peterz: Are you willing to pick up those patches?

Yeah.. no objections. Should I pick these up or will you be sending
another round?
