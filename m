From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Oct 2012 10:55:48 +0200
Subject: [PATCH RFC 02/15 v5] gpio: Add sysfs support to block GPIO API
In-Reply-To: <50813EB0.9040102@antcom.de>
References: <1350477107-26512-1-git-send-email-stigge@antcom.de>
 <1350477107-26512-3-git-send-email-stigge@antcom.de>
 <20121017190520.GC25996@kroah.com> <507FD4EB.1080204@antcom.de>
 <CACRpkda35jKs9YVNDAo96=0QzdMi+jkvJAzM=nX+HCK-d5+e9Q@mail.gmail.com>
 <50813EB0.9040102@antcom.de>
Message-ID: <CACRpkdagQhUjdbda55JaY-J33MTNsEMMFJ=1je8V428ZkEMb9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 1:51 PM, Roland Stigge <stigge@antcom.de> wrote:

> [Me]
>> The block GPIO stuff is just following that design pattern.
>
> So what do you think about my just proposed idea of always having the
> "value" argument present, but only useable when "exported" is "1"? Now
> only talking about the block gpios, but later maybe also for gpios?

We should atleast be consistent and do it the same way for
blocks as individual gpios.

> But I would only do this if you and Greg consider it reasonable.

I'm still afraid of this whole thing and would seek Grant's consent.

Yours,
Linus Walleij
