From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jun 2017 11:18:21 +0200
Subject: [PATCH 2/2] drivers/clocksource/fttmr010: Implement delay timer
In-Reply-To: <CACmBeS16+S1sCvvWtd835MD7atYeatEXRu-z-Hz27yD4DrJL+w@mail.gmail.com>
References: <20170611212617.6906-1-linus.walleij@linaro.org>
 <20170611212617.6906-2-linus.walleij@linaro.org>
 <CACmBeS16+S1sCvvWtd835MD7atYeatEXRu-z-Hz27yD4DrJL+w@mail.gmail.com>
Message-ID: <CACRpkdZwDpS_GrWTpZYK56YyTMnWjmEU_7fg-mPp3AA3+k6mMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 2:41 PM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> I stumbled upon boot time savings (going from next-20170518 to
> next-20170609) which seem to shave off more than a second ([1]
> compared to [2]) so I also booted without patches ([3]).
> There seems to be improvement when these patches are applied.

Oh yes, using delay timers saves us the loop calibration time.

Actually I should mention that, it's pretty nice.

Thanks for testing!

Yours,
Linus Walleij
