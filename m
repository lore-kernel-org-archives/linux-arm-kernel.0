From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Oct 2011 12:57:46 +0200
Subject: [PATCH v2] mach-ep93xx: break out GPIO driver specifics
In-Reply-To: <20111015204129.GZ21648@n2100.arm.linux.org.uk>
References: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
	<20111015181808.GA3128@mwesterb-mobl.ger.corp.intel.com>
	<20111015204129.GZ21648@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2MqHvKLs3eER8Qvof5a3F95ooabXBUAjNgsdd0xXXajhqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> However, as I had to use GNU patch to apply Linus' patch (as git apply
> wouldn't because of fuzz), it doesn't understand that, so it removed it.
> This is where having an /* empty */ comment avoids that kind of thing,
> just like I've done for all the other mach/gpio.h which became empty.

OK now I understand what happened, I'll have the /* empty */ comment
in them from now on...

Thanks,
Linus Walleij
