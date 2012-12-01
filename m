From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Dec 2012 18:01:01 +0100
Subject: [PATCH 1/2] input: gpio-keys: Disable hardware on suspend
In-Reply-To: <20121125083229.GB21091@core.coreip.homeip.net>
References: <1353590617-11466-1-git-send-email-lee.jones@linaro.org>
 <20121125083229.GB21091@core.coreip.homeip.net>
Message-ID: <CACRpkdYXcC-5hFG+nLK7AT6m-htrivwuhm-HodBnO0LY6RgGfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2012 at 9:32 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Nov 22, 2012 at 01:23:36PM +0000, Lee Jones wrote:
>> From: Jonas Aaberg <jonas.aberg@stericsson.com>
>>
>> Disable hardware if active when suspending if the hw can not
>> wake the system from suspend.
>
> How about below instead (needs the other patch I have just sent out)?

LooksGoodToMe(TM)

Acked-by.

Yours,
Linus Walleij
