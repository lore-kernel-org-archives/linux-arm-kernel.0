From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 09:20:02 +0200
Subject: [PATCH 21/33] clk: ux500: Add Device Tree support for the PRCC
 Kernel clock
In-Reply-To: <20130912145651.GJ11227@lee--X1>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-22-git-send-email-lee.jones@linaro.org>
 <CACRpkdY2KOxX=oA7i9GUnzpwRKiK2rXqTBPVpg+zW082f2TJdg@mail.gmail.com>
 <20130821101448.GJ29850@lee--X1>
 <CACRpkdYjvFTJAUL6xKxjkVd_v=DHHRkswoB_eq0Npqj5Sw23KQ@mail.gmail.com>
 <20130822092130.GB22023@lee--X1>
 <CACRpkdYLJdmhCqXpQ0s5nbxRoFdZ3bLn+hxAhkoGHYfvugc=7A@mail.gmail.com>
 <20130827082326.GE6152@lee--X1>
 <CACRpkdYvAfEh6UGa7qR_e9ynj3TkPSM2RKtr7Scw7L3p10AgXA@mail.gmail.com>
 <20130912145651.GJ11227@lee--X1>
Message-ID: <CACRpkdbr-Cuz14ZL_AGs4_SgDGQYgbpxQ_NjOakWrpX7gqzssA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 4:56 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 12 Sep 2013, Linus Walleij wrote:

>> But if you still don't like this, let me cook a counter-patch so
>> I can realized on my own how terribly wrong I am...
>
> I'm going to yank all of the clk_register_clkdev() calls out
> imminently anyway, so all those these hiding bugs will soon become
> apparent in any case. Why don't I place my 'remove ATAGs' patch-set
> on top of this one and then finally remove the clk_register_clkdev()s
> and watch the carnage ensue?

So that creates problem for me as maintainer if I need to
pull or revert some of the patches on top of the stack, all of
a sudden the file looks horrible. That is why I want every step
to be as clean a cut as possible.

Yours,
Linus Walleij
