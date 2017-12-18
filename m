From: j-keerthy@ti.com (Keerthy)
Date: Mon, 18 Dec 2017 18:24:42 +0530
Subject: [PATCH v5 0/8] omap: dmtimer: Move driver out of plat-omap
In-Reply-To: <20171218111610.GA16906@lenoch>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <20171218111610.GA16906@lenoch>
Message-ID: <3b721525-c97d-925d-5904-83515abc4b38@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 18 December 2017 04:46 PM, Ladislav Michl wrote:
> Keerthy,
> 
> On Tue, Dec 12, 2017 at 11:42:09AM +0530, Keerthy wrote:
>> The series moves dmtimer out of plat-omap to drivers/clocksource.
>> The series also does a bunch of changes to pwm-omap-dmtimer code
>> to adapt to the driver migration and clean up plat specific
>> pdata-quirks and use the dmtimer platform data.
> 
> thanks for nice work. I'll send two more patches as a reply to this
> one. I'd be glad if you could make them part of your serie. One of
> them would be nice to have for pwm driver prescaler fix which will
> be send independently.
> Also, if that helps you can have my
> Tested-by: Ladislav Michl <ladis@linux-mips.org>
> on IGEPv2 (OMAP3430 based)

Thanks a bunch! :-). I will take the pwm driver fix along with mine.

should i also take the two patches which you sent:

[PATCH 1/2] clocksource: timer-dm: Make unexported functions static
[PATCH 2/2] clocksource: timer-dm: Check prescaler value

Also what about this:
[PATCH] pwm: omap-dmtimer: Fix frequency when using prescaler

Let me know. I plan to send v6 with your Tested-by.

Thanks,
Keerthy

> 
>> Boot tested on DRA7-EVM and AM437X-GP-EVM.
> 
> I guess PWM driver was not tested, right? See comment to PATCH 7/8.
> 
>> Compile tested omap1_defconfig.

Yes! Thanks for your feedback.

> 
> Thank you,
> 	ladis
> 
