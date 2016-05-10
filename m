From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 May 2016 13:52:54 +0200
Subject: [RFC v5 3/4] gpio: move clps711x, moxart,
 ts4800 and gpio-ge into gpio-generic
In-Reply-To: <1518049.pLhlI1cuZi@debian64>
References: <cover.1461888822.git.chunkeey@googlemail.com>
 <9e5cc9e957144bd5d4081573ef959f931281eaaa.1461888822.git.chunkeey@googlemail.com>
 <CACRpkdaX1xeGJxV9K-GkTAh87SctqyhkJ+VN6mwUdtD19tz99g@mail.gmail.com>
 <1518049.pLhlI1cuZi@debian64>
Message-ID: <CACRpkdbXM2Bnzv_qTwz6sWkpCgx3q2ihiEMbeb+5DJj+DT+GAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 9:06 PM, Christian Lamparter
<chunkeey@googlemail.com> wrote:
> On Friday, April 29, 2016 04:18:20 PM Linus Walleij wrote:

>> Very elegant. Let's wait for some feedback/ACKs from
>> the driver maintainers, but this looks very nice.

> Oh by the way: who's maintaining them? get_maintainer.pl just
> lists the usual gpio people.

I usually just git log drivers/gpio/gpio-foo.c
and see what turns up, then sift out to avoid any generic
maintenance patches and mail the remaining people who
made real functional changes and seem  to be using the
real hardware.

> Anyway, I'll rebase my patch series (without the two patches you
> had already merged)

Awesome.

>> Do you want to address Andy's optimization suggestion directly
>> or as a follow-on patch?
>
> Oh, this is a RFC. I didn't expect anything to be merged just yet.
> Of course, I'll try to integrate his suggestion. I'll do that once
> I reply to Rob/Mark/You about the "linux,gpio-mmio",
> "memory-mapped-gpio" situation etc.

True, OK no hurries, I just liked the patches a lot.

Yours,
Linus Walleij
