From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 2 Oct 2015 22:49:38 +0200
Subject: [PATCH 0/9] UEFI boot and runtime services support for 32-bit ARM
In-Reply-To: <20151002203831.GE21513@n2100.arm.linux.org.uk>
References: <1443719063-6832-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151002203831.GE21513@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8Fin7h9LniFS+Q99UFd4+X_NbXD41432zU8xSz=UShjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2015 at 22:38, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 01, 2015 at 07:04:14PM +0200, Ard Biesheuvel wrote:
>> There are a number of prerequisites for this series that have all been
>> sent to the linux-arm-kernel mailing list at some point (and mostly
>> ignored).
>
> They've been ignored because they're UEFI and no one's said that it's
> something that 32-bit ARM should get... until this series has come
> along.  It might help if Linaro was more engaging with developers who
> aren't part of Linaro.
>

Actually, the first iteration of this series was sent out by Roy more
than two years ago.
But I am fully aware that these patches and the prerequisite series
(plural) still need thorough review, I am just throwing this series
out there early since it ties all of that together, so it puts the
other stuff into context.

> Now, I'm not going to suddenly drop what I'm working on to start trying
> to gain an understanding of UEFI, and what its implications are for
> 32-bit ARM so that I can reasonably review these patches - let me put
> that another way: don't expect me to review this stuff quickly and
> come out with review comments on something I have very ltitle clue
> about.  I have precisely zero UEFI knowledge.
>

I think the UEFI peculiarities are mostly covered by the common code
shared with x86 and arm64. What I would appreciate your input on is
the ARM specific thinks like early .data in the decompressor (even
before the GOT fixups), the early_ioremap addition and the changes to
create_mapping(). But no rush at all.

Thanks,
Ard.
