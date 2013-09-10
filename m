From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 10 Sep 2013 08:31:04 -0700
Subject: [GIT PULL 0/3] ARM: SoC: Second round of changes for v3.12
In-Reply-To: <1378825549.2627.316.camel@shinybook.infradead.org>
References: <1378766555-9679-1-git-send-email-khilman@linaro.org>
 <CA+55aFxNbH+G6DVQNxE9di_btA5hxFH93af_vjN2v0eH8e5W-g@mail.gmail.com>
 <1378825549.2627.316.camel@shinybook.infradead.org>
Message-ID: <CA+55aFyRUZMJiotV0kAUoeEFpFdvK2r-3rXuS7NO4jHoQ+OkPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 8:05 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>
> In cost-sensitive products (and what *isn't* cost-sensitive these days),
> you really don't want to have to put an extra EEPROM on the board
> somewhere

Don't be silly. Nobody wants an extra chip. Especially not one that is
programmable separately from the hardware. That way lies madness and
the usual firmware crazies.

It's not even what I asked for. I talked about discoverable buses. How
hard is that to understand? No extra chips, no eeprom, just a bus with
a notion of configuration cycles. It doesn't even have to be as
complicated as PCI, it could easily be a read-only model.

But no, every SoC designer out there seems to want to make their
hardware crap. Don't be surprised when I then call them out on the
fact. And don't bring up totally irrelevant issues that have nothing
to do with anything.

Is there a cost? Yes, it's a cost of good design and effort to try to
get it right. Usually that cost pays itself back over the years.

            Linus
