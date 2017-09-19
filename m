From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 19 Sep 2017 07:32:22 -0500
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
 <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
Message-ID: <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/19/17 3:15 AM, Linus Walleij wrote:
> Oh we already have that I think, Mika Westerberg and Andy Shevcheno
> implemented that for anyone using CONFIG_GPIOLIB_IRQCHIP, and
> this driver does. Timur please check: irq_need_valid_mask, irq_valid_mask
> usage.

These patches already use irq_valid_mask!  But that doesn't block 
complete access to the GPIO.


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
