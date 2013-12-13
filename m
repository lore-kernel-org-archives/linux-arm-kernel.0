From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Dec 2013 13:42:03 +0100
Subject: [PATCH 1/2] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <12061693.IYmMzIp37Y@flatron>
References: <1386857210-4944-1-git-send-email-linus.walleij@linaro.org>
 <12061693.IYmMzIp37Y@flatron>
Message-ID: <CACRpkdZeMZkodW2yt0px_zAozwci3xB5HMd4vreBME=afQofiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 11:30 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Thursday 12 of December 2013 15:06:50 Linus Walleij wrote:
> [snip]
>>  arch/arm/mach-s3c64xx/include/mach/gpio.h          |  93 -----------------
>
> Hmm, shouldn't this (and other s3c64xx-related changes) be in patch 2/2?

Hm yes, I wonder how I screwed this up... I'll move this to the other patch.

> Anyway, I've applied both, but unfortunately compilation for mach-s3c64xx
> (using s3c6400_defconfig) fails with following error:

Trying to reproduce and fix this.

Thanks!

Yours,
Linus Walleij
