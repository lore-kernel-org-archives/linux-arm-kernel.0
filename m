From: andrey.konovalov@linaro.org (Andrey Konovalov)
Date: Thu, 1 Oct 2015 19:42:04 +0300
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <20151001113642.GI12635@sirena.org.uk>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
 <20150930164103.GC15635@sirena.org.uk>
 <20151001111931.GD6963@e104818-lin.cambridge.arm.com>
 <20151001113642.GI12635@sirena.org.uk>
Message-ID: <560D625C.2010100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2015 02:36 PM, Mark Brown wrote:
> On Thu, Oct 01, 2015 at 12:19:31PM +0100, Catalin Marinas wrote:
>> On Wed, Sep 30, 2015 at 05:41:03PM +0100, Mark Brown wrote:
>
>>> Indeed.  On that subject there was some discussion at Linaro Connect
>>> last week about work (being done outside Linaro, not sure how public it
>>> is at this point) to pull together the current state of the art into a
>>> Docker container image which people can use for benchmarking and as a
>>> reference for how to pull things together.  That should help with the
>>> analysis, it'll at least make it easier for other people to reproduce
>>> any benchmarking results.

Using Docker image sounds like a great idea.

>> That's fine and I would welcome it. However, I'm definitely against
>> using non-agreed ABI and further spreading such toolchains (or kernel
>
> You might want to speak to some of your colleagues about that...  in any
> case I'll reply off list later today with information on the third party
> working on this so you can get in touch, like I say I'm not sure how
> public that work is at this point.
>
>> patches; Linaro's tracking kernel has kept these patches for a long
>> time, even though the ABI has been NAK'ed).
>
> I know, I'm not thrilled about that either.  :/

Same for me.
As you have noticed, ILP32 was removed from Linaro's tracking kernel recently.
The thing is that we (builds&baselines team in Linaro) have been requested
to have a CI loop for ILP32. So I'll continue running it, but will use a
separate git branch for ILP32. The linux-linaro branch will not have ILP32
any more (or at least until ILP32 ABI is agreed on).

Thanks,
Andrey

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
