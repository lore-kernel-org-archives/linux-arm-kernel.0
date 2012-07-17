From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jul 2012 20:57:19 +0200
Subject: [PATCH -next] random: Remove remaining relicts of
 rand_initialize_irq()
In-Reply-To: <20120717171251.GD6049@thunk.org>
References: <1342524793-2522-1-git-send-email-sedat.dilek@gmail.com>
 <20120717171251.GD6049@thunk.org>
Message-ID: <CACRpkdZe48FrDJx1p8ojfqwVBE95hSJipE8rViAi=E28uumYOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 7:12 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Jul 17, 2012 at 01:33:13PM +0200, Sedat Dilek wrote:
>> rand_initialize_irq() was removed here:
>>
>> commit 946672f548682905d8ecdab33bb6e2c705418505
>> "random: remove rand_initialize_irq()"
>>
>> The AB3100 mfd-driver is the only driver still using it and breaks
>> with the following error-messages in linux-next (next-20120717)
>
> Oops.  Sorry, I thought I had caught all of the users of
> rand_initialize_irq().  Thanks for catching this!
>
> I'll take your advice and merge it into the original commit.

So the IRQ will be auto-sampled now or something?

Sorry for not quite following, which commit do I look at to
understand this now...

Yours,
Linus Walleij
