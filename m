From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 8 Oct 2013 20:37:15 +0530
Subject: [PATCH] ARM: davinci: convert to clockevents_config_and_register
In-Reply-To: <20131008145723.GQ10079@pengutronix.de>
References: <1380060159-12008-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131008145723.GQ10079@pengutronix.de>
Message-ID: <52541FA3.4040207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe,

On Tuesday 08 October 2013 08:27 PM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Sep 25, 2013 at 12:02:39AM +0200, Uwe Kleine-K?nig wrote:
>> clockevents_config_and_register is superior compared to setting
>> shift/mult and {min,max}_delta_ns by hand.
>>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
>> ---
>> Hello,
>>
>> I wonder where the 50 us limit comes from. This is not a hardware limit,
>> is it?
> ping; I didn't get any feedback on this yet, also it's not in next.

Apologies for the delay. I am yet to look at it because I am traveling
ATM. I will look at it during this week and provide feedback.

Thanks,
Sekhar
