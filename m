From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 29 Aug 2011 21:18:29 +0800
Subject: [PATCH v4 00/18] Introduce a led trigger for CPU activity and
	consolidate LED driver in ARM
In-Reply-To: <CACRpkda6-8dxSbF12N-Q32cOpogu-ZZmTApnvNBa03iOcEeqaQ@mail.gmail.com>
References: <1314349415-889-1-git-send-email-bryan.wu@canonical.com>
	<CACRpkda6-8dxSbF12N-Q32cOpogu-ZZmTApnvNBa03iOcEeqaQ@mail.gmail.com>
Message-ID: <CAK5ve-JM=01vTqSi59R6ASyGU_2fVXzKtjNh42LKeF2HF3NzSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 7:00 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Aug 26, 2011 at 11:03 AM, Bryan Wu <bryan.wu@canonical.com> wrote:
>
>> Based on Linus Walleij's ARM LED consolidation work, this patchset introduce a
>> new generic led trigger for CPU not only for ARM but also for others.
>
> I think Russell was pretty clear that he saw problems inside the "new LEDs"
> subsystem (drivers/leds) that need be fixed before we migrate this support
> to use the LED class devices.
>
> Can you see if you can address his comment on the earlier realview patch,
> i.e. this:
> http://marc.info/?l=linux-arm-kernel&m=131237280009775&w=2
>

Yeah, I replied that email with a patch to select LEDS_CLASS when
CONFIG_NEW_LEDS=y.

But you know, there is no comments about that.

> rpurdie: your comments on the state of the LEDs class?
>
> If I get time I will attempt to fix it, no clue when that will be though.
>

Thanks a lot, I think our ledtrig-cpu patches are quite good for
merging, although Russell has some concern about leds subsystem.

Regards,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
