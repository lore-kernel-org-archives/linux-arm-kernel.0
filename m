From: rabin@rab.in (Rabin Vincent)
Date: Wed, 11 Aug 2010 00:41:59 +0530
Subject: [PATCH 05/10] ARM: ftrace: add ENDPROC annotations
In-Reply-To: <1281460072.16880.47.camel@e102109-lin.cambridge.arm.com>
References: <20100421192319.GA16719@debian>
	<1281460072.16880.47.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTi=Vf6NPxDqpL8ycpjXDNajTzdYVXFYdLq0CxJZ8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Aug 10, 2010 at 10:37 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, 2010-04-21 at 20:23 +0100, Rabin Vincent wrote:
>> When building as Thumb-2, the ".type foo, %function" annotation in
>> ENDPROC seems to be required in order for the assembly routines to be
>> recognized as Thumb-2 code. ?If the ENDPROC annotations are not present,
>> calls to these routines are generated as BLX instead of BL.
>>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Rabin Vincent <rabin@rab.in>
>
> What's the status of these patches? I haven't seen them in mainline.

They're in the patch tracker now.  I'd forgotten about them for a while,
and there was one patch missing an ack, but that's sorted out now.

Rabin
