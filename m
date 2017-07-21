From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Jul 2017 15:01:54 -0700
Subject: [PATCH 1/2] clk: qoriq: add clock configuration for ls1088a soc
In-Reply-To: <1491445283-13053-1-git-send-email-andy.tang@nxp.com>
References: <1491445283-13053-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170721220154.GL19878@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06, Yuantian Tang wrote:
> Clock on ls1088a chip takes primary clocking input from the external
> SYSCLK signal. The SYSCLK input (frequency) is multiplied using
> multiple phase locked loops (PLL) to create a variety of frequencies
> which can then be passed to a variety of internal logic, including
> cores and peripheral IP modules.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
