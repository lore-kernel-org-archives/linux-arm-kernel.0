From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 24 Jul 2015 14:39:00 -0700
Subject: [PATCH] clk: s2mps11: Use kcalloc instead of kzalloc for array
 allocation
In-Reply-To: <1437557693-29433-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437557693-29433-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150724213900.GG15042@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22, Vaibhav Hiremath wrote:
> This patch cleans up the driver for,
> 
>   - Use devm_kcalloc varient instead of devm_kzalloc for array
>     allocation.
>   - clk_prepare/unprepare, remove "ret" variable as it is not required
>   - use __exit for cleanup function
> 
> As I am referring this driver as a reference for my 88pm800 clk driver,
> applying same changes here as well.
> 
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
