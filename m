From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 5 May 2015 22:55:10 -0700
Subject: [PATCH 2/2] clk: s3c2410: Constify platform_device_id
In-Reply-To: <1430496168-32408-2-git-send-email-k.kozlowski.k@gmail.com>
References: <1430496168-32408-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430496168-32408-2-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150506055510.GE10871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
