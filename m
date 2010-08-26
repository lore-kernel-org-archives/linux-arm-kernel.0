From: konkers@android.com (Erik Gilling)
Date: Wed, 25 Aug 2010 17:02:24 -0700
Subject: [PATCH] video: tegra: add tegra display controller and fb driver
In-Reply-To: <4C75AE88.30809@bluewatersys.com>
References: <1281568272-25871-1-git-send-email-konkers@android.com>
	<4C6379E1.4010500@bluewatersys.com>
	<AANLkTini+n1osaQHkomguzZi-DaHLX3i1G4gA82bK0=S@mail.gmail.com>
	<4C75A039.8060701@bluewatersys.com>
	<AANLkTimTJKOgDKqpOR7LR-2gS1qQamke12m73hDru_=t@mail.gmail.com>
	<4C75AE88.30809@bluewatersys.com>
Message-ID: <AANLkTim1UYu1jn06aTeGvEKPM5R_GFWhsQi_2Z=AtCzf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 25, 2010 at 5:00 PM, Ryan Mallon <ryan@bluewatersys.com> wrote:
>>> Its useful for debugging while developing the driver, but it adds a lot
>>> of code. Do you expect the register dumping features to be required once
>>> the driver hits mainline?
>>
>> I expect the driver will hit mainline is several phases. ?This first
>> one. ?One where HDMI works. ?One where DSI works. ?One which has
>> rotation. ?This code is useful for all those phases.
> ...
>> They still fill different uses. ?You can't cat a debugfs file from an
>> interrupt handler. ?You can't call dump_regs() from userspace. ?I'm
>> still actively using both. ?I could see taking one out once
>> development on the driver calms down.
>
> Okay, maybe keep both with a comment stating why the debug is still
> there, and that it is scheduled to be removed once the driver is
> complete in mainline?

OK will do.
