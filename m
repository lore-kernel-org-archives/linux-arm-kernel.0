From: agross@codeaurora.org (Andy Gross)
Date: Tue, 16 Jun 2015 15:32:35 -0500
Subject: [PATCH] spmi: Select IRQ_DOMAIN instead of depend on it
In-Reply-To: <1434479836-20947-1-git-send-email-sboyd@codeaurora.org>
References: <1434479836-20947-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150616203235.GB8507@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 11:37:16AM -0700, Stephen Boyd wrote:
> IRQ_DOMAIN is a hidden config option, so depending on it doesn't
> make any sense. Select the config option because it's required to
> compile this driver.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
