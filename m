From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 9 Feb 2016 11:39:26 -0600
Subject: [PATCH v11 4/4] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <1455037240-16192-5-git-send-email-fu.wei@linaro.org>
References: <1455037240-16192-1-git-send-email-fu.wei@linaro.org>
 <1455037240-16192-5-git-send-email-fu.wei@linaro.org>
Message-ID: <56BA244E.1020402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fu.wei at linaro.org wrote:

> +		if (!action)
> +			dev_warn(dev, "fall back to signle stage mode.\n");

"falling back to single stage mode"

Acked-by: Timur Tabi <timur@codeaurora.org>

The whole "calculate the timeouts different if 'action' is enabled" 
seems clunky to me, but I can't think of a better way to handle it.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
