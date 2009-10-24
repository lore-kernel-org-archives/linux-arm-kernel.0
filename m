From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 24 Oct 2009 10:25:18 +0200
Subject: [RFC] mx31moboard: patches for next merge window
In-Reply-To: <4AD836C2.7070707@epfl.ch>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
	<20091016081722.GB7208@pengutronix.de> <4AD836C2.7070707@epfl.ch>
Message-ID: <20091024082518.GA3358@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Valentin,

On Fri, Oct 16, 2009 at 11:02:58AM +0200, Valentin Longchamp wrote:
> Uwe Kleine-K?nig wrote:
>> On Thu, Oct 15, 2009 at 11:42:54AM +0200, Valentin Longchamp wrote:
>>> Here are the patches I would like to push during the next merge window for
>>> the mx31moboard platform.
>>>
>>> It consists of a fix for a small hardware design issue for the main serial
>>> port, a few GPIOs used on the robots that are declared, camera support and
>>> finally MC13783 support as it is now getting ready.
>>>
>>> For MC13783, we would need RTC as well, but I did not add it yet since it
>>> is not in mainline yet.
>> Note I'm currently overhauling mc13783-core.c resulting in an API change.
>>
>> I plan to add some compatibility stuff, but I'll let you know when I'm
>> done anyhow.  Are you interested in testing my changes?
>
> Sure. Tell me when you have something and I will give them a spin on the  
> robot.
Yesterday I sent out my update to the mc13783-core driver, and just
remembered when I was in bed that I forgot to Cc: you.  You can find it
together with some other more or less related patches in my repository
at

	git://git.pengutronix.de/git/ukl/linux-2.6.git mc13783

(It contains the last pull request by Sascha, another patch for spi-imx,
and else MC13783 related patches: hwmon (already accepted upstream),
touchscreen and rtc.)

I will follow up this mail with the rtc patch for review by the rtc
people.  Compared with the patch by Sascha it got reset detection and
works on top of my rewritten mc13783-core driver.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
