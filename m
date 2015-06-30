From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 30 Jun 2015 09:06:51 +0900
Subject: [PATCH] clk: samsung: fix cpu clock's flags checking
In-Reply-To: <1435598978-21800-1-git-send-email-b.zolnierkie@samsung.com>
References: <1435598978-21800-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5591DD9B.4030507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.06.2015 02:29, Bartlomiej Zolnierkiewicz wrote:
> CLK_CPU_HAS_DIV1 and CLK_CPU_NEEDS_DEBUG_ALT_DIV masks were
> incorrectly used as a bit numbers.  Fix it.
> 
> Tested on Exynos4210 based Origen board and on Exynos5250 based
> Arndale board.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/clk/samsung/clk-cpu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
