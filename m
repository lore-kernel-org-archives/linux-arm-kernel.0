From: brueckner@linux.ibm.com (Hendrik Brueckner)
Date: Tue, 27 Nov 2018 09:19:45 +0100
Subject: [PATCH v2 15/20] s390: perf/events: advertise PMU exclusion
 capability
In-Reply-To: <1543230756-15319-16-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
 <1543230756-15319-16-git-send-email-andrew.murray@arm.com>
Message-ID: <20181127081945.GA4817@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 11:12:31AM +0000, Andrew Murray wrote:
> The s390 cpum_cf and cpum_sf PMUs have the capability to exclude
> events based on context. Let's advertise that we support the
> PERF_PMU_CAP_EXCLUDE capability to ensure that perf doesn't
> prevent us from handling events where any exclusion flags are set.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/s390/kernel/perf_cpum_cf.c | 1 +
>  arch/s390/kernel/perf_cpum_sf.c | 2 ++
>  2 files changed, 3 insertions(+)

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
