From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 21 Aug 2011 00:09:53 -0700
Subject: [PATCH 00/19] GPIO exodus and cleanup
In-Reply-To: <CACRpkdYw96QD0sGOhA=osKYbnD6=MTqiAF=m5++BjM-s1Mn--w@mail.gmail.com>
References: <1312978564-18069-1-git-send-email-linus.walleij@stericsson.com>
	<20110817090123.GD1006@n2100.arm.linux.org.uk>
	<CACRpkdbJOrb5rhgG0Chamt-ApLQnV69MQ=bqBwKqO3KJPaFd0A@mail.gmail.com>
	<CACRpkdYw96QD0sGOhA=osKYbnD6=MTqiAF=m5++BjM-s1Mn--w@mail.gmail.com>
Message-ID: <CACxGe6tEOnUzFjKMqNfp10b8SyuJDDFzg0eiPzhKNNCY55LECw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 5:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 17, 2011 at 11:37 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Wed, Aug 17, 2011 at 11:01 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Wed, Aug 10, 2011 at 02:16:04PM +0200, Linus Walleij wrote:
>>>> The following patch set is rebased on top of Russell's
>>>> 13 cleanup patches and can be finalized as soon as there
>>>> is a branch in RMKs tree that can accumulate this work.
>>>
>>> If Grant acks the relevant ones, they can go to the patch system and
>>> merged into that branch.
>>
>> Thanks that'd be smooth.
>>
>> Grant can you N/ACK the patches you consider relevant for
>> the GPIO subsystem?
>
> Ping on this, on monday I'll pretend it's no big deal and pour them
> into Russells patch tracker anyway, since he's managing more than
> half of the kernels GPIO code in arch/arm/* anyway.

If Russell is okay with it, then go ahead and merge it.  I'm being
pretty liberal about GPIO driver moves.  I'm fine with them getting
cleaned up after the drivers/gpio move.

g.
