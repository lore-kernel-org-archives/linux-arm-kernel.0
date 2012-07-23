From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Jul 2012 16:54:43 +0200
Subject: [PATCH -next] random: Remove remaining relicts of
 rand_initialize_irq()
In-Reply-To: <20120717214219.GF6049@thunk.org>
References: <1342524793-2522-1-git-send-email-sedat.dilek@gmail.com>
 <20120717171251.GD6049@thunk.org>
 <CACRpkdZe48FrDJx1p8ojfqwVBE95hSJipE8rViAi=E28uumYOQ@mail.gmail.com>
 <20120717214219.GF6049@thunk.org>
Message-ID: <CACRpkdbgt9kNTbF6YfL1rEbwWLA85a6b4crsOzTfedM+3KJBbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 11:42 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Jul 17, 2012 at 08:57:19PM +0200, Linus Walleij wrote:
>> So the IRQ will be auto-sampled now or something?
>>
>> Sorry for not quite following, which commit do I look at to
>> understand this now...
>
> Yes, there was a huge discussion on LKML about two weeks ago.  The
> key commit that will be going in during the next merge window is:
>
> http://git.kernel.org/?p=linux/kernel/git/tytso/random.git;a=commitdiff;h=775f4b297b780601e61787b766f306ed3e1d23eb

I get it now, after checking the commit and reading the LWN
article. It's all looking good,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
