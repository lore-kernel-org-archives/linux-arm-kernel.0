From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Sep 2011 07:25:45 +0200
Subject: [PATCH] mach-integrator: fix VGA base regression
In-Reply-To: <4E64EB24.7010800@gmail.com>
References: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
	<4E64496E.1090000@gmail.com>
	<CACRpkdYw4WCJ+kBm_FBH=H-vPKBUsb9DFToK0MN4F8t5T8Tc9g@mail.gmail.com>
	<4E64EB24.7010800@gmail.com>
Message-ID: <CAKnu2MrFsnZrq-Fzq3HpV8oAwa9Vi6fFqrSSB7+kq8r8V7ANQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/5 Rob Herring <robherring2@gmail.com>:

>>> Should the VGA memory really be accessed before PCI host is initialized?
>>
>> I don' know, I don't know one bit about how PCI works and should
>> work, you tell me :-)
>
> I guess it's normal (from init/main.c):

Ah. I've even seen that comment in main.c.

SHall I go over the other changes in the same and check for
potential problems?

> Well, it's really no difference with your patch or reverting mine in
> terms of init order. I'd rather not have to add back hardware.h as a
> required mach header.

No please. Let's go for this patch and potentially others if
there are related problems.

> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks!
Linus Walleij
