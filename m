From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 5 Feb 2015 21:37:15 +0530
Subject: [PATCH v3 3/3] ARM: EXYNOS: Remove left over 'extra_save'
In-Reply-To: <1423121002-25117-3-git-send-email-k.kozlowski@samsung.com>
References: <1423121002-25117-1-git-send-email-k.kozlowski@samsung.com>
 <1423121002-25117-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAGcde9GiJRWFwtObWCOZeOo1Ax2MfjtaOEv0iNPNo5W9UDjTFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof

On 5 February 2015 at 12:53, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
>
> Since 32b0aa9aaeb4 ("ARM: EXYNOS: Remove i2c sys configuration related
> code") the Exynos 5250 no longer saves additional registers under
> 'exynos_pm_data.extra_save' field.
>
> No one else uses this code so get rid of it making also 'exynos_pm_data'
> const everywhere.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
