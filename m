From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Jul 2018 21:41:09 +0200
Subject: [RFT v2 01/10] pinctrl: samsung: Define suspend and resume
 callbacks for all banks and SoCs
In-Reply-To: <20180723175302.22535-2-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
 <20180723175302.22535-2-krzk@kernel.org>
Message-ID: <20180724194109.vbkahhcpi7avmj2m@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 07:52:53PM +0200, Krzysztof Kozlowski wrote:
> Suspend and resume callbacks in Exynos/S5Pv210 pin controller drivers,
> save and restore state of registers.  This operations should be done for
> all banks which have external interrupts (as denoted by using
> EXYNOS_PIN_BANK_EINTG/EINTW macros).
> 
> Add all banks of Exynos5260 and Exynos5420.  This is necessary step for
> supporting suspend to RAM on these SoCs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Thanks, applied.

Best regards,
Krzysztof
