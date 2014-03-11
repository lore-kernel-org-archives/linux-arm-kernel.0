From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 11 Mar 2014 13:21:17 +0100
Subject: [PATCH 2/5] ARM: dts: exynos4x12: Add PMU dt data to support
 PMU(Perforamnce Monitoring Unit)
In-Reply-To: <1394524494-30641-3-git-send-email-cw00.choi@samsung.com>
References: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
 <1394524494-30641-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <531EFFBD.8050301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 11.03.2014 08:54, Chanwoo Choi wrote:
> ARM CPU has its own performance profiling unit(PMU, Perforamnce Monitoring Unit).
> This patch add PMU dt data to support PMU which count cache hit and miss events.
>
> PMU interrput list of Exynos4212
> - <2 2> : INTG2[2] - PMUIRQ[0] for CPU0
> - <3 2> : INTG3[2] - PMUIRQ[1] for CPU1
>
> PMU interrput list of Exynos4412
> - <2 2> : INTG2[2], PMUIRQ[0] for CPU0
> - <3 2> : INTG3[2], PMUIRQ[1] for CPU1
> - <18 2> : INTG18[2], PMUIRQ[2] : CPU2
> - <19 2> : INTG19[2], PMUIRQ[3] : CPU3
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4x12.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
