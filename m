From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 09:41:07 +0100
Subject: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask
 is changed
In-Reply-To: <20131114182447.GJ10317@atomide.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
 <CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
 <20131011172337.GU29913@atomide.com>
 <CACRpkdbo_TwX79hnJ5mCo8D4TSDd6OUzaOsFa8MgzjLy-H2U4Q@mail.gmail.com>
 <20131112195611.GT15154@atomide.com>
 <20131114182447.GJ10317@atomide.com>
Message-ID: <CACRpkdbLWnkoRtG1jJg73XWKveMSbf244SbmNdXN+cdEfEMcew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 7:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [131112 11:57]:

>> The fix from Roger is still missing. You can go ahead and queue
>> it, or if you prefer me to do it I can add it to my fixes.
>
> Actually Linus, I'll queue this with your ack as the interrupts-extended
> property is now merged in and I can also enable some minimal wake-up
> events for omap3.

OK thanks for the heads-up, go ahead.

Yours,
Linus Walleij
