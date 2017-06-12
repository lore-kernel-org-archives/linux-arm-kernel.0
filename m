From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 12 Jun 2017 16:32:28 +0200
Subject: [PATCH 5/6] arm64: wire frequency-invariant accounting support up
 to the task scheduler
In-Reply-To: <20170608075513.12475-6-dietmar.eggemann@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-6-dietmar.eggemann@arm.com>
Message-ID: <CAKfTPtDzsWPgZsf0gMSKPR7GJ8ovmvdW3_vXv=eyVH_Z6buYzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> Commit dfbca41f3479 ("sched: Optimize freq invariant accounting")
> changed the wiring which now has to be done by associating
> arch_scale_freq_capacity with the actual implementation provided
> by the architecture.
>
> Define arch_scale_freq_capacity to use the arch_topology "driver"
> function topology_get_freq_scale() for the task scheduler's
> frequency-invariant accounting instead of the default
> arch_scale_freq_capacity() in kernel/sched/sched.h.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
