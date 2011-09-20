From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Sep 2011 10:45:49 +0200
Subject: [PATCH 15/19] plat-pxa: break out GPIO driver specifics
In-Reply-To: <CAMPhdO9eL_Sdq-=TCami=CkwWeYR3XeF0K=n9L0uzjS88YTsRA@mail.gmail.com>
References: <1312978697-18572-1-git-send-email-linus.walleij@stericsson.com>
	<CAMPhdO9eL_Sdq-=TCami=CkwWeYR3XeF0K=n9L0uzjS88YTsRA@mail.gmail.com>
Message-ID: <CACRpkdbGfhZnLaP9p27T1qbD0NVsW7Spp9ZVbR6zEGBSFU+M9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 4:38 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Aug 10, 2011 at 8:18 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The <mach/gpio.h> file is included from upper directories
>> and deal with generic GPIO and gpiolib stuff. Break out the
>> platform and driver specific defines and functions into its own
>> header file.
>>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I think there is better way around this, am working on it with several
> patches already, will release soon.

Anything happening on this front or shall I update this patch set?

Yours,
Linus Walleij
