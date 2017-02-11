From: timur@codeaurora.org (Timur Tabi)
Date: Sat, 11 Feb 2017 15:32:15 -0600
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
Message-ID: <51200db0-552b-221d-1e81-f1a3ee286c6c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd wrote:
>> > +	/* 0 = output, 1 = input */
>> > +	return val & BIT(g->oe_bit) ? 0 : 1;
> Maybe we can use the macros GPIOF_DIR_IN and GPIOF_DIR_OUT here instead?

Ok, I posted a v2.

Is it too late for this patch to make the 4.11 merge window, or maybe 4.11-rc2? 
 From the perspective of our server platform, it's a bug fix.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
