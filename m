From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 21 Sep 2013 17:19:01 +0200
Subject: [PATCH 3/6] clk: exynos5250: add clock ID for div_pcm0
In-Reply-To: <1379711637-5226-3-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379711637-5226-3-git-send-email-abrestic@chromium.org>
Message-ID: <3865571.vRPq0Or7Pr@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Friday 20 of September 2013 14:13:54 Andrew Bresticker wrote:
> There is no gate for the PCM clock input to the AudioSS block, so
> the parent of sclk_pcm is div_pcm0.  Add a clock ID for it so that
> we can reference it in device trees.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  Documentation/devicetree/bindings/clock/exynos5250-clock.txt | 1 +
>  drivers/clk/samsung/clk-exynos5250.c                         | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
