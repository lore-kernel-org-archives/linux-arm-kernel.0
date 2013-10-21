From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 21 Oct 2013 22:53:23 +0200
Subject: [GIT PULL] fixes for integer rounding in timer core
In-Reply-To: <20131021071240.GI10079@pengutronix.de>
References: <alpine.DEB.2.02.1309191629040.4089@ionos.tec.linutronix.de>
 <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5253D9A1.1080106@pengutronix.de> <20131008153147.GR10079@pengutronix.de>
 <20131014073436.GX10079@pengutronix.de>
 <20131021071240.GI10079@pengutronix.de>
Message-ID: <52659443.2050203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2013 09:12 AM, Uwe Kleine-K?nig wrote:
> Hello,
>
> [added Daniel Lezcano to To:]
>
> On Mon, Oct 14, 2013 at 09:34:37AM +0200, Uwe Kleine-K?nig wrote:
>> On Tue, Oct 08, 2013 at 05:31:47PM +0200, Uwe Kleine-K?nig wrote:
>>>> What's the status of this patch?
>>> I pinged Thomas about it already via irc, but I didn't get a response up
>>> to now. It would be great to get that into 3.12. To make it easy for
>>> Thomas, here is a pull request that includes the fix and converts
>>> at91rm9200 back to clockevents_config_and_register dropping one of the
>>> workarounds for the fixed bug.

[ ... ]

>>> ----------------------------------------------------------------
>>> The first patch in this pull request fixes an old integer rounding bug in the
>>> timer core that was (and still is) worked around in a few arch's timer code.
>>> The second patch drops such a work around now that the core is fixed.
>> It would be nice to get that fix into 3.12, but Thomas stopped
>> responding nearly a month ago---his last mail in this thread[1] dates back
>> to September 20.
> Still no sign of life from Thomas.
>
>> Can one of you please take it directly?
> Daniel, would you care to take it?

Yes, sure.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
