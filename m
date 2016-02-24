From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Feb 2016 16:59:16 +0100
Subject: [PATCH] ARM: realview: DT support for the PBA8
In-Reply-To: <CACRpkdbQKZxMgYRUq6cjAXHq5q1EufVwcHG=wJ0QsDcqUVoRhQ@mail.gmail.com>
References: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
 <56CDA0F0.9050608@arm.com>
 <CACRpkdbQKZxMgYRUq6cjAXHq5q1EufVwcHG=wJ0QsDcqUVoRhQ@mail.gmail.com>
Message-ID: <CACRpkdbYB8pkgiE9NevOgR2WJpwv03ng5ZUwCMt=4=BsTVokfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 4:52 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Feb 24, 2016 at 1:24 PM, Robin Murphy <robin.murphy@arm.com> wrote:

>> Waiting for root device /dev/mmcblk0p1...
>>
>> It then fails to notice my SD card, even if I eject and reinsert it :(
>
> Fixing a v2 as we speak.

Also notice: if you want working graphics, I have a pending CLCD patch
set for that, and then there is a patch for reset too. I still hope to land
it all for v4.6 and delete the board files but it depends on a few subsystem
maintainers.

Yours,
Linus Walleij
