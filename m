From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Oct 2017 21:38:57 +0100
Subject: [PATCH] ARM: omap2plus_defconfig: enable NEON based crypto
In-Reply-To: <20171002194817.GQ4394@atomide.com>
References: <20170906184729.7980-1-ard.biesheuvel@linaro.org>
 <20171002194817.GQ4394@atomide.com>
Message-ID: <CAKv+Gu9MKnNXTXLYhAB5GaXpqzP=Fa=7aTONzAZCCayj8EFGsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2017 at 20:48, Tony Lindgren <tony@atomide.com> wrote:
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> [170906 11:48]:
>> Enable kernel mode NEON and the various NEON based crypto algorithms,
>> which are between 1.4x (AES-XTS) and 2.4x (AES-GCM) faster than
>> scalar code (measured on Cortex-A8).
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> Note that this was tested using the updated GHASH code that is queued
>> for v4.14
>
> Applying finally into omap-for-v4.15/defconfig thanks.
>

Thanks Tony.
