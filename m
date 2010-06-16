From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 16 Jun 2010 11:43:29 +0800
Subject: [PATCH] ARM: Add ARCH_HAS_L2X0 and make CACHE_L2X0 config depend
	on that
In-Reply-To: <20100614145956.GA29355@lixom.net>
References: <1276272211-13065-1-git-send-email-olof@lixom.net>
	<1276279087.31800.6.camel@c-dwalke-linux.qualcomm.com>
	<20100613051625.GA7248@trinity.fluff.org>
	<20100614145956.GA29355@lixom.net>
Message-ID: <AANLkTimH979ASCut4dEE0FGJ-3PA3jzfHg_SzVM6eor_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 14, 2010 at 10:59 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Jun 13, 2010 at 06:16:26AM +0100, Ben Dooks wrote:
>> On Fri, Jun 11, 2010 at 10:58:07AM -0700, Daniel Walker wrote:
>> >
>> > I made a similar change not too long ago, but Russell wanted the define
>> > to be HAVE_CACHE_L2X0 ..
>>
>> possibly, I was thinking ARM_L2X0 would also be an option, since if I
>> remeber correctly it is selecting the driver not the availability of
>> it.
>
> Yeah, there are lots of different possible names. :)
>
> Let's just go with the one Russell preferred and not worry too much
> about it. There's some presendence to using HAVE_.* already.
>

Sometimes I am thinking that maybe ARCH_HAS_* has some benefits:

HAVE_* for those kernel-wide and general capabilities
ARCH_HAS_* for those ARM machine-class specific capabilities?

So to make things a bit more clear? If ARCH_HAS_* is widely adopted
on architectures other than ARM, maybe we can then switch that name
to HAVE_*?
