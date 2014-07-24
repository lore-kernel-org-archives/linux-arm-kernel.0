From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Jul 2014 14:35:05 +0200
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
In-Reply-To: <mvm4my7j5xh.fsf@hawking.suse.de>
References: <mvmvbri4k06.fsf@hawking.suse.de>
 <CAKv+Gu-NAVjMR-Jkw=W-8f7M5FSsQOSdzYN6A0kHDd1m0WA8EA@mail.gmail.com>
 <mvmr4264i1p.fsf@hawking.suse.de>
 <CAKv+Gu8SbM_Z=ymBFb2D4EWJeo-6dWuKqE2YNOkqJTKLDEJcYA@mail.gmail.com>
 <mvm4my7j5xh.fsf@hawking.suse.de>
Message-ID: <CAKv+Gu-6rUxUnF+dRuroDJqy2K2B5F0r7_bm0X-vyiuQ-83W5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2014 14:29, Andreas Schwab <schwab@suse.de> wrote:
> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>
>> On 30 June 2014 15:56, Andreas Schwab <schwab@suse.de> wrote:
>>> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>>>
>>>> Out of curiosity, how did you trigger this failure? I have build this
>>>> code numerous times (and so have others) and I have never seen this
>>>> failure.
>>>
>>> Did you ever start with a clean tree?
>>>
>>
>> Yep, building both in-tree and out-of-tree, no trouble at all.
>
> So you probably didn't configure them as modules.
>

Yes, all the time, in fact. They have now been added as built-ins to
the defconfig, but I always build as modules, because it is far easier
when developing.
