From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 22 Dec 2010 13:03:18 +0100
Subject: [PATCH v3 1/1] input/tc3589x: add tc3589x keypad support
In-Reply-To: <20101222102050.GE22590@core.coreip.homeip.net>
References: <1292927011-6898-1-git-send-email-sundar.iyer@stericsson.com>
	<20101222102050.GE22590@core.coreip.homeip.net>
Message-ID: <AANLkTimc4aT+NzQgcY+-Wm0oyFqqO9Fi3qREjPvcT1B0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/22 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Tue, Dec 21, 2010 at 03:53:31PM +0530, Sundar Iyer wrote:
>> Add support for the keypad controller module found on the
>> TC3589X devices. This driver default adds the support for
>> TC35893 device.
>>
>> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
>> ---
>> Changes:
>> ?- v3: introduced keypad_stopped flag to check suspend/resume/open/close
>> ? ? ? ?operations
>
> Acked-by: Dmitry Torokhov <dtor@mail.ru>
>
> Thanks for making the changes.

I've applied it to the ux500-core branch and pushed so
it gets tested in -next with the rest of the tc3589x stuff...

Yours,
Linus Walleij
