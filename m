From: madhavi.linux@gmail.com (Madhavi Manchala)
Date: Tue, 1 Mar 2011 15:23:02 +0530
Subject: Linux support for Samsung S3C2510A Processor
In-Reply-To: <20110228133256.GB22646@trinity.fluff.org>
References: <AANLkTinBZCQ7Q+BaSxhm62pKiZHhmVWAgNzxnm5jBhZy@mail.gmail.com>
	<20110228133256.GB22646@trinity.fluff.org>
Message-ID: <AANLkTikPENDpe32hJcV1fgKfJ_WOaOqqddZPD0cQLPUc@mail.gmail.com>
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

Thank you very much for the information.

I think, if I want to port the Linux on to my board, which is based on
Samsung s3c2510a processor, then I need to develop the
arch/arm/mach-s3c2510 sources, which are currently not available in
the kernel source tree.

I saw that you only developed the sources for Samsung s3c24xx
processor in arch/arm/ of the Linux sources.

So, please suggest me with some good links / points for writing the
sources for Samsung s3c2510a processor under arch/arm. At least, how
can I start? Any templates?

Thank you very much for your suggestions.

Thanks and Regards,
Madhavi M.

> --
> Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/
>
> Large Hadron Colada: A large Pina Colada that makes the universe disappear.
>
>
