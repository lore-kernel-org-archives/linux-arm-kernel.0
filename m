From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Jul 2014 16:21:47 +0200
Subject: [RFC PATCH 04/10] arm64: add EFI little endian constants to
 linker script
In-Reply-To: <20140730141805.GA15082@console-pimps.org>
References: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
 <1405955785-13477-5-git-send-email-ard.biesheuvel@linaro.org>
 <20140730141805.GA15082@console-pimps.org>
Message-ID: <CAKv+Gu8haTMur6GXVPMyLO_7Z2idQqXi978LqLD=HgkySvd2CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 July 2014 16:18, Matt Fleming <matt@console-pimps.org> wrote:
> On Mon, 21 Jul, at 05:16:19PM, Ard Biesheuvel wrote:
>> Similar to how text offset and kernel size are mangled to produce little
>> endian constants for the Image header regardless of the endianness of the
>> kernel, this adds a number of constants used in the EFI PE/COFF header which
>> can only be calculated (and byte swapped) by the linker.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/image.h | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> Where is this file? I can't find it in Linus' tree.
>

Apologies, I failed to mention that this series depends on arm64 for-next/core

https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core

-- 
Ard.
