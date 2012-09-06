From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Sep 2012 09:35:21 +0200
Subject: [GIT PULL] Renesas ARM-based SoC: KZM-A9-GT for 3.7 #2
In-Reply-To: <CACRpkdZBOjO124w3WwPpL7ekf2dU1w2HCub9EG=LUxFSPn8Ayw@mail.gmail.com>
References: <1346305648-25263-1-git-send-email-horms@verge.net.au>
 <20120905224413.GC32084@quad.lixom.net>
 <CACRpkdZBOjO124w3WwPpL7ekf2dU1w2HCub9EG=LUxFSPn8Ayw@mail.gmail.com>
Message-ID: <CACRpkdaj0Jc3TKgkC6AUt-j4t+hQg5weGrceTfROHaYmW1KsBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 7:58 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Sep 6, 2012 at 12:44 AM, Olof Johansson <olof@lixom.net> wrote:
>
>> So, we can't pull in this branch with its dependency without an agreement that
>> Linus holds a branch stable with at least the pcf857x patch on it. Linus?
>
> OMG! OK let's claim that it's stable now then, it's close enough
> to the merge window.

Oh! And by the way, make sure you pull in the "devel" branch:

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git devel

My "for-next" is a mixdown of fixes and devel, so the stuff that
will really go into next merge window is on devel.

Yours,
Linus Walleij
