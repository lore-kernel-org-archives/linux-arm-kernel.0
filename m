From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Oct 2014 14:02:50 +0200
Subject: [PATCH v2 0/5] pinctrl: samsung: Data structure clean-up
In-Reply-To: <CACRpkdY1GjDEfRH=48e24m+UcKzdPhROJBKDertS+q+e0td03g@mail.gmail.com>
References: <1412275931-10807-1-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdY1GjDEfRH=48e24m+UcKzdPhROJBKDertS+q+e0td03g@mail.gmail.com>
Message-ID: <CACRpkdbFB+o5VAtHUf97GAONmSFc_7wMuzPN8p_JDdiGW8vfLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 8, 2014 at 12:23 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Oct 2, 2014 at 8:52 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
>> This series intends to clean up data structures used by pinctrl-samsung driver.
>> More specifically, it separates initial compile time constants from data used
>> at runtime, allowing unused variant data to be dropped and selected structures
>> constified to improve safety.
>
> Thanks!
>
> The patches missed the v3.18 merge window, but I have queued them up as
> the first thing to go into v3.19.

I wrote somewhere else that this exploded somehow.

I've merged Abhilash's patches so now this work needs to be rebased
on top of his stuf...


Yours,
Linus Walleij
