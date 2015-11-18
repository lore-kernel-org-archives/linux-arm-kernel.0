From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Nov 2015 16:52:36 +0100
Subject: [PATCH v7 0/4] KASAN for arm64
In-Reply-To: <564C9DCC.50205@arm.com>
References: <1444665180-301-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151013083432.GG6320@e104818-lin.cambridge.arm.com>
 <5649BAFD.6030005@arm.com> <5649F783.40109@gmail.com>
 <20151116165100.GE6556@e104818-lin.cambridge.arm.com>
 <564C8C47.1080904@gmail.com> <564C9DCC.50205@arm.com>
Message-ID: <CAKv+Gu9hP3vaQUo62X5_15jRKwxA6P2d=wHtbVWMqm=FPNvNbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 November 2015 at 16:48, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
> On 18/11/15 14:33, Andrey Ryabinin wrote:
>
>> Is there any way to run 16K pages on emulated environment?
>> I've tried:
>>   - ARM V8 Foundation Platformr0p0 (platform build 9.4.59)
>
>
> Have you tried with the following option ?
>
> -C cluster<N>.has_16k_granule=1
>

That is only supported on FVP Base, not the Foundation model.

-- 
Ard.
