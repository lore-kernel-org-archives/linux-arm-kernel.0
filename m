From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 10 Oct 2011 16:01:08 +0800
Subject: [PATCH 5/9] ARM: SPMP8000: Add pinmux driver
In-Reply-To: <CAKnu2MrXWoOka9D++q3h-KfgyYRhGA81Tcf07y7VdEUszZrU9w@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-6-git-send-email-zoss@devai.org>
	<CAKnu2MrXWoOka9D++q3h-KfgyYRhGA81Tcf07y7VdEUszZrU9w@mail.gmail.com>
Message-ID: <CAGsJ_4zaqk_ECjaCXPeYJMRASE1zND+cZ2cwaLYVDhaVjsfSVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/10 Linus Walleij <linus.walleij@linaro.org>:
> 2011/10/9 Zoltan Devai <zoss@devai.org>:
>
>> ?arch/arm/mach-spmp8000/pinmux.c | ?131 +++++++++++++++++++++++++++++++++++++++
>> ?1 files changed, 131 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-spmp8000/pinmux.c
>
> I'm creating this new pin control and pin mux subsystem,
> set for next merge window. Can you check it out and see
> if it does what you need?

yes. Zoltan, you do need to follow Linus W's new pinmux framework.

And Linus, can you help to take care prima2 pinmux driver v3 i sent
yesterday and make sure it is merged in the window too.
our lots of device drivers depend on it, so i'd like it is ready
before we upstream lots of other drivers.

>
> http://marc.info/?l=linux-kernel&m=131805699106465&w=2
>
> Thanks,
> Linus Walleij

-barry
