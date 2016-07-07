From: joe@perches.com (Joe Perches)
Date: Wed, 06 Jul 2016 17:19:11 -0700
Subject: [PATCH v7 1/4] MAINTAINERS: Add entry for APM X-Gene SoC PMU
 driver
In-Reply-To: <1467850045-10584-2-git-send-email-ttnguyen@apm.com>
References: <1467850045-10584-1-git-send-email-ttnguyen@apm.com>
 <1467850045-10584-2-git-send-email-ttnguyen@apm.com>
Message-ID: <1467850751.8360.56.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 17:07 -0700, Tai Nguyen wrote:
> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
> ---
> ?MAINTAINERS | 8 ++++++++
> ?1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -8593,6 +8593,14 @@ L:	linux-scsi at vger.kernel.org
> ?S:	Supported
> ?F:	drivers/scsi/pm8001/
> ?
> +PMU-XGENE
> +APPLIED MICRO (APM) X-GENE SOC PMU

One line section header please.

> +M:	Tai Nguyen <ttnguyen@apm.com>
> +S:	Supported
> +F:	drivers/perf/xgene_pmu.c
> +F:	Documentation/perf/xgene-pmu.txt
> +F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
> +
> ?POSIX CLOCKS and TIMERS
> ?M:	Thomas Gleixner <tglx@linutronix.de>
> ?L:	linux-kernel at vger.kernel.org
