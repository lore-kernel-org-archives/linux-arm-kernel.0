From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2011 13:00:42 +0200
Subject: [PATCH v4 00/18] Introduce a led trigger for CPU activity and
	consolidate LED driver in ARM
In-Reply-To: <1314349415-889-1-git-send-email-bryan.wu@canonical.com>
References: <1314349415-889-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <CACRpkda6-8dxSbF12N-Q32cOpogu-ZZmTApnvNBa03iOcEeqaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 11:03 AM, Bryan Wu <bryan.wu@canonical.com> wrote:

> Based on Linus Walleij's ARM LED consolidation work, this patchset introduce a
> new generic led trigger for CPU not only for ARM but also for others.

I think Russell was pretty clear that he saw problems inside the "new LEDs"
subsystem (drivers/leds) that need be fixed before we migrate this support
to use the LED class devices.

Can you see if you can address his comment on the earlier realview patch,
i.e. this:
http://marc.info/?l=linux-arm-kernel&m=131237280009775&w=2

rpurdie: your comments on the state of the LEDs class?

If I get time I will attempt to fix it, no clue when that will be though.

Thanks,
Linus Walleij
