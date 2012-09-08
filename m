From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 8 Sep 2012 11:45:58 +0200
Subject: [PATCH 1/4] ARM: ks-8695: merge the timer header into the timer
 driver
In-Reply-To: <CAOesGMiyd8xnXSMbeHXEed7r-PR2CnNcp=nMA3W5sM6Q-3p1xw@mail.gmail.com>
References: <1346264802-20306-1-git-send-email-linus.walleij@linaro.org>
 <CAOesGMiyd8xnXSMbeHXEed7r-PR2CnNcp=nMA3W5sM6Q-3p1xw@mail.gmail.com>
Message-ID: <CACRpkdZZdMf07ayGSZ4FBz3hL-LXEqKnsfhwVQMXoYwqGM7SbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2012 at 5:34 AM, Olof Johansson <olof@lixom.net> wrote:

>> This <mach/regs-timer.h> is broadcasted in the entire kernel for
>> no good reason, since it's only used by the timer driver. Merge
>> it into the driver.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Actually, it's also included in the watchdog timer that is only
> enabled on the acs5k defconfigs today, not on the main ks8695 one :(
>
> drivers/watchdog/ks8695_wdt.c:27:29: fatal error: mach/regs-timer.h:
> No such file or directory

OK I'll fix pronto.

Yours,
Linus Walleij
