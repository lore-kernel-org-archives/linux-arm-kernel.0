From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 11:20:44 +0900
Subject: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
In-Reply-To: <1436456621-29839-3-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-3-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <559F2BFC.4030806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.07.2015 00:43, Bartlomiej Zolnierkiewicz wrote:
> Turbo modes should be marked with CPUFREQ_BOOST_FREQ flag in
> the frequency table entry.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/cpufreq_opp.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
