From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 13:32:57 +0100
Subject: [PATCH] ARM: u300: fix timekeeping when periodic mode is used
In-Reply-To: <20131125211347.GD28642@pengutronix.de>
References: <20131105083336.GK14892@pengutronix.de>
 <1383642199-11473-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdZrV7fPcyNeBdzhhZHDkm1ZmixwDi=1=vKnFOBiYTQYsw@mail.gmail.com>
 <20131125211347.GD28642@pengutronix.de>
Message-ID: <CACRpkdY47AR35ndrTvg7inOmF=Gb8oq3XMM_KtDDEifaq339GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 10:13 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Nov 05, 2013 at 10:44:58AM +0100, Linus Walleij wrote:
>> On Tue, Nov 5, 2013 at 10:03 AM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>>
>> > To determine the value to write to the hardware's timer counter register
>> > the symbol CLOCK_TICK_RATE is used. This value is a dummy value on u300
>> > though. So instead use the clock rate that is used for oneshot mode.
>> >
>> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Thanks, patch applied to the u300 branch in the linux-stericsson
>> tree.
>
> This isn't in next? At least this patch doesn't appear there.

I missed to send it upstream for v3.13, sorry.

It is in my U300 patch queue, I'll send a pull request to ARM SoC
ASAP.

Yours,
Linus Walleij
