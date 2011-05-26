From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 May 2011 07:38:11 -0500
Subject: [PATCH] arm: vexpress: move v2m clock init to init_early
In-Reply-To: <20110526030520.GB19723@game.jcrosoft.org>
References: <1306362653-25668-1-git-send-email-robherring2@gmail.com>
	<20110526030520.GB19723@game.jcrosoft.org>
Message-ID: <4DDE49B3.6050001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2011 10:05 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:30 Wed 25 May     , Rob Herring wrote:
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> Commit 7ff550de99141cbd3be0129d563cc4554fdde9f6 breaks vexpress booting. The
>> v2m clock table needs to be setup in init_early before the timer
>> initialization occurs.
>>
>> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
>> ---
>>   arch/arm/mach-vexpress/v2m.c |   15 +++++++--------
>>   include/linux/libata.h       |    4 ++--
> why do you touch the libata?

Oops. Accidentally picked up some other stuff. Disregard that part.

Rob
