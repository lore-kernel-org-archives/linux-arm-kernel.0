From: vb@vsbe.com (vb at vsbe.com)
Date: Wed, 16 Feb 2011 18:02:29 -0800
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTi=PLJBZ=Q-4k8ZUbX4S3w7f3WfUd9acb7iVYGBP@mail.gmail.com>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
	<alpine.LFD.2.00.1102152257500.14920@xanadu.home>
	<AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
	<AANLkTi=PLJBZ=Q-4k8ZUbX4S3w7f3WfUd9acb7iVYGBP@mail.gmail.com>
Message-ID: <AANLkTi=_=jzs+MrvGbwF3L0c_eSq4nnbqE-xZ_+Z5fgH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 1:19 AM, Dave Martin <dave.martin@linaro.org> wrote:
>>
>> Note that while the bulk of the kernel is Thumb-2 safe, there are
>> occasional regressions, and individual platforms and drivers could
>> still have problems. ?For now, I've been focusing on omap--- see
>>
>> git://git.linaro.org/people/dmart/linux-2.6-arm.git dirty/arm/omap-thumb2+merged
>>
>> ARM: Add local symbols in relocate_kernel.S to work around gas bugs
>
> ^ Oops, forgot to explain that line: this is the patch required to
> work around a specific bug in the assembler. ?I'm not currently
> proposing to merge this upstream, since I prefer the assembler to get
> fixed...
> You can grab this patch from the branch.
>

Dave, thank you for this information. I checked out this branch and
would like to build a kernel. I don't know what omap is though, can
you please share a config file one could use to build the thumb
enabled kernel for it?

TIA,
cheers,
Vadim



>>
>> If you're trying to support a specific board I'm unlikely to be able
>> to debug it for you, but feel free to ping me with questions.
>>
>> Cheers
>> ---Dave
>>
>
