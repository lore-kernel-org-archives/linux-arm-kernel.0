From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 24 Feb 2014 11:20:36 +0100
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <CACRpkdZ1JR82m46YV5m=b6e3E3OYcNCka_8EiT2VcSPU=ZVLdQ@mail.gmail.com>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdZ1JR82m46YV5m=b6e3E3OYcNCka_8EiT2VcSPU=ZVLdQ@mail.gmail.com>
Message-ID: <530B1CF4.2060208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/14 11:17, Linus Walleij wrote:
> On Mon, Feb 24, 2014 at 9:42 AM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>
>> This is a patches separated from one sent earlier [1] with just the
>> removal of any hard-coded reg addresses from Dove pinctrl stub.
>
> OK let's queue this a while later on top of the other stuff (that I'm working
> on applying right now).

Ok.

>> In the meantime, support for new Armada 375/38x was added that also
>> contain patches for pinctrl [2].
>
> I applied these first. Please look at the result once I push out the
> pinctrl tree with the 375/38x + your v4 series in combination
> (let's see how big mess it will be...)
>
> I'm sorry for not applying the nice patches earlier, forcing you to work
> on many parallel series like this, hopefully I'll be able to attend to
> them this week.

It's okay, I don't expect you to jump on every patch set we sent
immediately.

Although, I guess instead of applying them separately, it would have
been better to pull them from Jason's stable topic branch. But that is
also up to you and Jason may give valuable hints on how to proceed in
the future.

Thanks anyway!

Sebastian
