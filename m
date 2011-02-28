From: madhavi.linux@gmail.com (Madhavi Manchala)
Date: Mon, 28 Feb 2011 20:01:04 +0530
Subject: Linux support for Samsung S3C2510A Processor
In-Reply-To: <20110228133256.GB22646@trinity.fluff.org>
References: <AANLkTinBZCQ7Q+BaSxhm62pKiZHhmVWAgNzxnm5jBhZy@mail.gmail.com>
	<20110228133256.GB22646@trinity.fluff.org>
Message-ID: <AANLkTi=Ya0Aw9sqzsS2vw+S50w48qMnKHMnE6nf4g0Wq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 7:02 PM, Ben Dooks <ben@trinity.fluff.org> wrote:
> On Mon, Feb 28, 2011 at 06:52:15PM +0530, Madhavi Manchala wrote:
>> Dear All,
>>
>> Does Linux kernel supports the Samsung S3C2510A processor? Why am I
>> asking this question is, when I looked into ?the arch/arm/ directory I
>> did not find anything which is related to Samsung S3C2510A processor.
>> There are other directories like mach-s3c24xx and mach-s3c64xx
>> directories, but not mach-s3c25xx.
>>
>> Any ideas / hints will be appreciated.
>
> I think this is a no-mmu version, and there is not a lot of ARM no-mmu
> support at the moment.

Dear Ben,

Thanks for you information.

As you said, it is not a MMU CPU.

That is, we do not port the Linux directly on to my board. If I want
to support Linux on my board which is based on the Samsung S3C2510A,
what is the procedure for it? Please suggest me.

Thanks and Regards,
Madhavi M.

> --
> Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/
>
> Large Hadron Colada: A large Pina Colada that makes the universe disappear.
>
>
