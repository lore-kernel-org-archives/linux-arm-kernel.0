From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Oct 2015 15:00:57 +0100
Subject: [PATCH 1/3] mtd: create a partition type device tree binding
In-Reply-To: <20151029162908.GA13275@localhost>
References: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
 <20151029162908.GA13275@localhost>
Message-ID: <CACRpkdYS5Jf8UC2K0bNdEQZDjTeZZx44Uu-kkof+9E=4Ny0oDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 5:29 PM, Brian Norris
<computersforpeace@gmail.com> wrote:

>> +Required properties:
>> +- partition-type : the type of partition. Only one type can be specified.
>
> You're supporting this as a list property (for future expansion,
> presumably), so I can only assume the "only one type" is referring to
> the number of different parsers available currently, not the behavior of
> the property itself?

I was thinking that it would not be a list actually.

The reason being that if you're anyways going to the trouble of
specifying exactly what partition type is going to be used, you're
not really interested in specifying a few different ones, you know
exactly what type it is going to be.

But if you think it needs to be a list, I'll specify that, no big
deal. I'll also try to get the Linux code to handle a list then.

> Also, this patch will conflict with [1]. I'll probably take [1] soon, so
> one of us will have to rebase this.

Sure I'll rebase on whatever you say.

Yours,
Linus Walleij
