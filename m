From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 09 Dec 2013 14:31:48 +0100
Subject: [PATCH 1/1] clk: exynos5250: Add CLK_SET_RATE_PARENT flag to
 mout_apll
In-Reply-To: <1385007454-5234-1-git-send-email-sachin.kamat@linaro.org>
References: <1385007454-5234-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1466487.IbnMiN0f0X@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On Thursday 21 of November 2013 09:47:34 Sachin Kamat wrote:
> Add CLK_SET_RATE_PARENT flag to be able to change the frequency
> to desired value.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/clk/samsung/clk-exynos5250.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Your patch description is a bit off. It doesn't say frequency of what
clock will be able to be changed to "desired value" and what is the reason
for this change.

Best regards,
Tomasz
