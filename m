From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 3 Aug 2018 12:48:46 -0300
Subject: [PATCH] perf vendor events arm64: Enable JSON events for eMAG
In-Reply-To: <d6d9db03-657e-005c-8aa2-d0b3b41acb47@huawei.com>
References: <20180803041811.17065-1-seanvk.dev@oregontracks.org>
 <d6d9db03-657e-005c-8aa2-d0b3b41acb47@huawei.com>
Message-ID: <20180803154846.GG7996@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Aug 03, 2018 at 03:41:06PM +0100, John Garry escreveu:
> On 03/08/2018 05:18, Sean V Kelley wrote:
> > This patch adds the Ampere Computing eMAG file.  This platform
> > follows the ARMv8 recommended IMPLEMENTATION DEFINED events, where
> > applicable.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > Cc: William Cohen <wcohen@redhat.com>
> > 
> > Signed-off-by: Sean V Kelley <seanvk.dev@oregontracks.org>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, applied.

- Arnaldo
