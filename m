From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 13 May 2012 15:59:14 -0400
Subject: [PATCH] ARM: integrator: fix typo in PCI swizzle function
In-Reply-To: <20120513160925.GA13947@n2100.arm.linux.org.uk>
References: <1336813546-25766-1-git-send-email-linus.walleij@linaro.org>
 <CAP=VYLrTRQn_MQdB6mVC5qpPB1f6W8Maw8gaPN2TPRDy9c5Nvw@mail.gmail.com>
 <20120513160925.GA13947@n2100.arm.linux.org.uk>
Message-ID: <CAP=VYLq2RruXJP29n4oE+2nDV=qCbt2Ff-z4GzEobXGcctJW+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2012 at 12:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, May 13, 2012 at 12:04:40PM -0400, Paul Gortmaker wrote:
>> On Sat, May 12, 2012 at 5:05 AM, Linus Walleij <linus.walleij@linaro.org>
>> wrote:
>> > The next tree didn't compile due to a typo in commit
>> > cfb32a689949d09f112493de4a1e3e5900db2053
>> > "ARM: PCI: integrator: use common PCI swizzle"
>>
>> While the above commit may have played a role, it wasn't the
>> one that actually caused the final build fail. ?I bisected to the
>> failing commit and sent the same fix for this over a week ago.
>>
>> http://www.spinics.net/lists/arm-kernel/msg172951.html
>>
>> Should I also be Cc'ing arm at kernel.org on all prospective
>> ARM fixes I find in linux-next in the future?
>
> Take a moment to have a think about whether arm-soc can fix a change
> that's in my tree...

Yeah, good point.  I just hate to see wasted/duplicated work and
was wondering if I was missing something when I just sent the
above fix to you and linux-arm-kernel vs. logging it in the patch
tracker and/or expanding the CC list in some way.

Paul.
---

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
