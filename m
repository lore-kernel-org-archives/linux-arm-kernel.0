From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Oct 2018 10:04:14 +0100
Subject: [PATCH 5/6] arm64: perf: Move event definitions into perf_event.h
In-Reply-To: <7fa991a1-40b2-08cf-11cf-8c41124496d8@arm.com>
References: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
 <1539189115-16221-6-git-send-email-will.deacon@arm.com>
 <7fa991a1-40b2-08cf-11cf-8c41124496d8@arm.com>
Message-ID: <20181011090414.GB20836@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 06:27:04PM +0100, Suzuki K Poulose wrote:
> On 10/10/18 17:31, Will Deacon wrote:
> >+/* Statistical profiling extension microarchitectural events */
> >+#define	ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
> >+#define	ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4000
> >+#define	ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE			0x4000
> >+#define	ARMV8_SPE_PERFCTR_SAMPLE_COLLISION			0x4000
> 
> This appears to be a mistake of copy-paste. The numbers must be
> 
> +#define	ARMV8_SPE_PERFCTR_SAMPLE_POP			0x4000
> +#define	ARMV8_SPE_PERFCTR_SAMPLE_FEED			0x4001
> +#define	ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE		0x4002
> +#define	ARMV8_SPE_PERFCTR_SAMPLE_COLLISION		0x4003
> 
> Otherwise looks good to me.

Duh. Thanks.

Will
