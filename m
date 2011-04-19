From: jochen@scram.de (Jochen Friedrich)
Date: Tue, 19 Apr 2011 16:46:32 +0200
Subject: [PATCHv2 2.6.40 3/3] ARM:simpad: add GPIO based device
	definitions.
In-Reply-To: <20110419135210.GA2182@rainbow>
References: <1303131636-19442-1-git-send-email-jochen@scram.de>
	<1303131636-19442-4-git-send-email-jochen@scram.de>
	<20110419135210.GA2182@rainbow>
Message-ID: <4DADA048.2090306@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

>>   arch/arm/mach-sa1100/Makefile      |    1 -
>>   arch/arm/mach-sa1100/leds-simpad.c |   97 ------------------------------------
>>   arch/arm/mach-sa1100/simpad.c      |   95 ++++++++++++++++++++++++++++++++++-
>>   3 files changed, 94 insertions(+), 99 deletions(-)
>>   delete mode 100644 arch/arm/mach-sa1100/leds-simpad.c
>
> But, while removing leds-simpad.c, it seems you forgot to update both
> Makefile and corresponding entries in leds.[ch], so I suspect it will
> break build with CONFIG_LEDS=y.

Thanks for the review. I'll update my patch.

> And, while you're at it, it's probably a good idea to move all these LED
> changes into separate patch, and not to mix them with gpio-keys/i2c/etc
> devices registration.

I'll seperate the LED stuff from the rest of the patch.

Thanks,
Jochen
