From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 9 Sep 2009 13:17:18 +0200
Subject: [PATCH 1/2] AB3100 regulator support v4
In-Reply-To: <20090909093500.GC4292@sortiz.org>
References: <1251982396-23790-1-git-send-email-linus.walleij@stericsson.com>
	<1251987348.6735.49.camel@odin>
	<63386a3d0909081507n7071761fyb7c8350072129fcd@mail.gmail.com>
	<20090909093500.GC4292@sortiz.org>
Message-ID: <63386a3d0909090417l742cfa88u9747558c3e04d08d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/9 Samuel Ortiz <sameo@linux.intel.com>:

> On Wed, Sep 09, 2009 at 12:07:05AM +0200, Linus Walleij wrote:
>> 009/9/3 Liam Girdwood <lrg@slimlogic.co.uk>:
>>
>> > Samuel, are you happy for this to go via mfd for simpler merging ?
>> > If so :-
>> >
>> > Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
>>
>> OK with you Sam?
>
> Yes, applied to my for-next branch. There were a couple checkpatch 80+
> character line length warnings, but I'm not that picky :)

Thanks a lot Sam, I think all these warnings are of the type where
dev_*(); messages get more than 80 characters long, and that has
been indicated by Linus (the other one) and some subsystem maintainers
to be undesireable to break across lines in order to avoid hassles
when grep:ing for error strings in the kernel tree.

Linus Walleij
