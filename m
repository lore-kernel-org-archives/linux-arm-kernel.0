From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Apr 2013 15:28:37 +0200
Subject: [PATCH 01/23] ARM: u300: fix ages old copy/paste bug
In-Reply-To: <201304221334.04160.arnd@arndb.de>
References: <1366624283-6122-1-git-send-email-linus.walleij@stericsson.com>
 <201304221334.04160.arnd@arndb.de>
Message-ID: <CACRpkdYnk1L3z19yQUJciKOOLUGV_rj3f231-jFKYjcE41kRsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 1:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 22 April 2013, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The UART1 is on the fast AHB bridge, not on the slow bus.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Do you want to mark this for stable?
>
> While there are not a lot of people that would need the fix, I think
> we should do it by habit in cases that fit the stable rules.

OK you're right. I'm sending this one separately to
arm at kernel.org as a fix and marked as stable.

Yours,
Linus Walleij
