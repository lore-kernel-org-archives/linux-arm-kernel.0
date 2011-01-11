From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Jan 2011 21:12:36 -0800
Subject: [PATCH] TWD: enable one-shot mode
In-Reply-To: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
References: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
Message-ID: <4D2BE6C4.4040806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24/2010 11:18 AM, Russell King - ARM Linux wrote:
> Allow one shot timer mode to be used with the TWD.  This allows
> NOHZ mode to be used on SMP systems using the TWD localtimer.
>
> Tested on Versatile Express.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Acks/Tested-by's would be appreciated, thanks.
>

I see this patch was already tested and merged but can you elaborate on
why this was done? From what I understand, NOHZ selects one-shot (like
is done in this patch), so why don't the machines with a TWD choose NOHZ
or high res timers?

Putting it another way, if my machine supports a oneshot capable
clockevent device should I be selecting oneshot regardless of the NOHZ
and high res config option being chosen?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
