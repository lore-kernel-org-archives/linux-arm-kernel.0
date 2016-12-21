From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 15:34:14 -0800
Subject: [PATCH v2 3/3] clk: zte: add audio clocks for zx296718
In-Reply-To: <1481873207-22929-4-git-send-email-shawnguo@kernel.org>
References: <1481873207-22929-1-git-send-email-shawnguo@kernel.org>
 <1481873207-22929-4-git-send-email-shawnguo@kernel.org>
Message-ID: <20161221233414.GF8288@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16, Shawn Guo wrote:
> From: Jun Nie <jun.nie@linaro.org>
> 
> The audio related clock support is missing from the existing zx296718
> clock driver.  Let's add it, so that the upstream ZX SPDIF driver can
> work for HDMI audio support.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Applied to clk-next + I added static to some more structures.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
