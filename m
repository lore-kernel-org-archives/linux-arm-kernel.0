From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Jun 2015 11:56:51 -0700
Subject: [PATCH 12/14] ARM: berlin: move BG2Q clock node
In-Reply-To: <1431735823-28006-13-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1431735823-28006-13-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20150604185651.GD676@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16, Sebastian Hesselbarth wrote:
> From: Antoine Tenart <antoine.tenart@free-electrons.com>
> 
> With the introduction of the Berlin simple-mfd controller driver, all
> drivers previously sharing the chip and system controller nodes now
> have their own sub-node.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
