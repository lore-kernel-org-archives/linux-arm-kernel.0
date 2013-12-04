From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 04 Dec 2013 10:13:23 +0100
Subject: [PATCH v2] clocksource: sirf/marco+prima2: drop usage of
 CLOCK_TICK_RATE
In-Reply-To: <20131204085233.GH29721@pengutronix.de>
References: <529729D1.7030803@linaro.org>
 <1385644882-450-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131204085233.GH29721@pengutronix.de>
Message-ID: <529EF233.1080307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 09:52 AM, Uwe Kleine-K?nig wrote:
> Hello Daniel,
>
> On Thu, Nov 28, 2013 at 02:21:22PM +0100, Uwe Kleine-K?nig wrote:
>> Since CSR SiRF was converted to multi platform in cf82e0e (ARM: sirf:
>> enable multiplatform support) the symbol CLOCK_TICK_RATE isn't the
>> platform specific definition any more, but a global dummy value. There
>> was no harm introduced in cf82e0e because the global value happens to
>> match the old platform specific one, still this dummy value isn't
>> intended to be used and will hopefully disappear soon, so introduce a
>> local #define and use that instead.
>>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Judging from your last comments I'd expect that you are happy with this
> patch now. Can I please have your blessing to forward this patch in my
> timex series to the arm-soc people?

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
