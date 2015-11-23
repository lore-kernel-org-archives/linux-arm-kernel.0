From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 23 Nov 2015 10:21:06 -0800
Subject: [PATCH] pinctrl: qcom: pmic-gpio/mpp: of_irq_count() == npins
In-Reply-To: <1447875197-21645-1-git-send-email-sboyd@codeaurora.org>
References: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
 <1447875197-21645-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151123182106.GO30882@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 18 Nov 11:33 PST 2015, Stephen Boyd wrote:

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

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
