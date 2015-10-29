From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 29 Oct 2015 07:38:53 +0530
Subject: [PATCH] ARM: EXYNOS: Constify local exynos_pmu_data structure
In-Reply-To: <1446082845-4974-1-git-send-email-k.kozlowski@samsung.com>
References: <1446082845-4974-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAGcde9GCbzt2F8DznfV+w5Lo3Gm-ORCxCiG3BRJryxiuyX-7bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2015 at 07:10, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> The Exynos5420 instance of exynos_pmu_data structure is not modified and
> can be made const.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Pavel Fedin <p.fedin@samsung.com>

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
