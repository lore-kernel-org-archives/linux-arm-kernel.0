From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 20 Jan 2014 13:07:30 +0100
Subject: [PATCH 2/2] clk: exynos4: Fix spacing related checkpatch errors
In-Reply-To: <1389780070-4959-2-git-send-email-sachin.kamat@linaro.org>
References: <1389780070-4959-1-git-send-email-sachin.kamat@linaro.org>
 <1389780070-4959-2-git-send-email-sachin.kamat@linaro.org>
Message-ID: <52DD1182.80200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On 15.01.2014 11:01, Sachin Kamat wrote:
> Silences the following type of checkpatch errors:
> ERROR: space prohibited after that open parenthesis '('
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   drivers/clk/samsung/clk-exynos4.c |   50 ++++++++++++++++++-------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)

I believe this is a false warning. In this special case the spaces 
greatly improve readability of static data in the driver, which I 
believe is preferred over the strict rules of checkpatch.

Best regards,
Tomasz
