From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2012 14:09:30 +0200
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <CACRpkdaDi8KMk0tyWuEHGnLWhZ4ufnNY4cUm-+q9kKryBztzkw@mail.gmail.com>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdaDi8KMk0tyWuEHGnLWhZ4ufnNY4cUm-+q9kKryBztzkw@mail.gmail.com>
Message-ID: <CACRpkdZF-J_P9M2hOZhnJtNrUE_2exefUg1Tj7S_dj0jUPBuKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 2:56 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 6, 2012 at 6:32 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>
>> This converts the ARM RealView machine over to using the common
>> clock. The approach is similar to the one used for the Integrator,
>> and we're reusing the ICST wrapper code.
>
> Mike have you had time to look at this? I got Pawel's ACK in the thread.

Ping again on this, if it's OK it would be great to get some rotation in
-next for this patch.

Yours,
Linus Walleij
