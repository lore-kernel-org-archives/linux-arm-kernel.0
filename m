From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 28 Aug 2015 12:50:19 +0200
Subject: [PATCH] clk: samsung: fix cpu clock's flags checking
In-Reply-To: <1435598978-21800-1-git-send-email-b.zolnierkie@samsung.com>
References: <1435598978-21800-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <55E03CEB.4070102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/15 19:29, Bartlomiej Zolnierkiewicz wrote:
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

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
