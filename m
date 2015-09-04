From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 3 Sep 2015 21:00:08 -0700
Subject: [PATCH v2 3/7] drivers: cpu: Define CPU devices as IRQ safe
In-Reply-To: <1441310314-8857-4-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <20150904040008.GM15099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03, Lina Iyer wrote:
> CPUs may be powered off from CPUIdle or hotplug and are called with
> IRQ's disabled. Define CPU devices as IRQ safe, so they may be runtime
> suspended/resumed.
> 
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
