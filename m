From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Nov 2017 18:44:51 -0800
Subject: [PATCH] clk: hi3660: fix incorrect uart3 clock freqency
In-Reply-To: <20170807145156.7880-1-guodong.xu@linaro.org>
References: <20170807145156.7880-1-guodong.xu@linaro.org>
Message-ID: <20171111024451.GD22441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07, Guodong Xu wrote:
> From: Zhong Kaihua <zhongkaihua@huawei.com>
> 
> UART3 clock rate is doubled in previous commit.
> 
> This error is not detected until recently a mezzanine board which makes
> real use of uart3 port (through LS connector of 96boards) was setup
> and tested on hi3660-hikey960 board.
> 
> This patch changes clock source rate of clk_factor_uart3 to 100000000.
> 
> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
