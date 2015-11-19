From: agross@codeaurora.org (Andy Gross)
Date: Thu, 19 Nov 2015 00:04:26 -0600
Subject: [PATCH] pinctrl: qcom: pmic-gpio/mpp: of_irq_count() == npins
In-Reply-To: <1447875197-21645-1-git-send-email-sboyd@codeaurora.org>
References: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
 <1447875197-21645-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151119060426.GA22622@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 11:33:17AM -0800, Stephen Boyd wrote:
> The number of interrupts is always equal to the number of pins
> provided by the PMIC gpio and MPP hardware blocks. Count the
> number of irqs to figure out the number of pins instead of adding
> more compatible strings or doing math on the reg property. This
> should make the code more generic and ease the number of changes
> we have to make to the driver for each new pmic revision.
> 
> Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

This is pretty nice. 

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
