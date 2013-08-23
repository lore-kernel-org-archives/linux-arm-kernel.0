From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 24 Aug 2013 01:00:53 +0200
Subject: [PATCH v2 2/4] clk: implement clk_unregister
In-Reply-To: <20130823215838.8231.21635@quantum>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
 <1377020063-30213-3-git-send-email-s.nawrocki@samsung.com>
 <20130823215838.8231.21635@quantum>
Message-ID: <5217E9A5.8030503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 11:58 PM, Mike Turquette wrote:
>> +static void clk_nodrv_disable_unprepare(struct clk_hw *hw)
>> >  +{
>> >  +       WARN_ON(1);
>
> Ideally we shouldn't get here, but if we do I guess it could be very
> noisy. How about WARN_ONCE?

Yes, I guess that would be much better. I could resend it tomorrow if 
needed.

> After you address Russell's comments in patch #1 I will be happy to take
> this series.

I have posted today v3 addressing Russell's comments. Hopefully patch #3
(the patches got reordered) looks OK now. v3 includes actual assigning
of clk->owner I somehow managed to miss in previous series :/ Please have
a look at it.

--
Regards,
Sylwester
