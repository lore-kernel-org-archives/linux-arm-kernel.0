From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Nov 2012 13:54:39 +0100
Subject: [PATCH 3/5] gpiolib: remove duplicate pin range code
In-Reply-To: <CAOh2x=nT8_95uu9tfEnOHy9Gkm6gEEAVAKKwPAqbLJz3bwFDNw@mail.gmail.com>
References: <1352215014-30305-1-git-send-email-linus.walleij@stericsson.com>
 <CAOh2x=nT8_95uu9tfEnOHy9Gkm6gEEAVAKKwPAqbLJz3bwFDNw@mail.gmail.com>
Message-ID: <CACRpkdbZ8VLixWwKOEUMNe+6BJOwCs0Me3=7_oR8xvT9MZx1Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2012 at 6:14 AM, viresh kumar <viresh.kumar@linaro.org> wrote:
> On Tue, Nov 6, 2012 at 8:46 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> Commit 69e1601bca88809dc118abd1becb02c15a02ec71
>> "gpiolib: provide provision to register pin ranges"
>>
>> Introduced both of_gpiochip_remove_pin_range() and
>> gpiochip_remove_pin_ranges(). But the contents are exactly
>> the same so remove the OF one and rely on the range deletion
>> in the core.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I can't believe that i did this :(

Don't worry, it's impossible to get these things right. I am
trying to fix it properly here and just introduce new bugs
for every fix I try to make.

Maybe I'll soon have something that actually doesn't
break x86...

Yours,
Linus Walleij
