From: hechtb@googlemail.com (Bastian Hecht)
Date: Wed, 24 Oct 2012 15:35:11 +0200
Subject: Possible regression in arm/io.h
In-Reply-To: <20121024130957.GB7339@mudshark.cambridge.arm.com>
References: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
 <20121024105223.GC23775@mudshark.cambridge.arm.com>
 <CABYn4swp9JBEHgGTOkoe=tOh3Mf1dq5WYr=2xuKNpTmLX5LcFQ@mail.gmail.com>
 <20121024130957.GB7339@mudshark.cambridge.arm.com>
Message-ID: <CABYn4sz4v7Uf07am=MtPAKAvvAjwt+-bTRaLrBjoiRuyR9cfZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/24 Will Deacon <will.deacon@arm.com>:
> On Wed, Oct 24, 2012 at 01:34:18PM +0100, Bastian Hecht wrote:
>> 2012/10/24 Will Deacon <will.deacon@arm.com>:
>> > It sounds like we need to:
>> >
>> >         (a) Understand what has changed in GCC to cause this error to start
>> >             cropping up.
>> >
>> >         (b) Have a look at the impact of using only "Q" on the generated
>> >             code (especially register usage for the address).
>> >
>>
>> Uff... I've just started to write ARM assembly and have no practical
>> experience with the inner workings of real world compilers. So this
>> time I'm afraid I was just good enough to report this. It sounds
>> interesting to hunt it, but would take ages for me at this point.
>
> Ok, I'll have a look at the impact of moving exclusively to "Q" when I get a
> chance. Which toolchain are you using?

gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
For a more verbose info take a look at the bug report link.

> Will
