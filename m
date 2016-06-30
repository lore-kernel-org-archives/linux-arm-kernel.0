From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 30 Jun 2016 18:16:31 +0200
Subject: [PATCH 0/5] arm64: avoid block entries that we need to split later
In-Reply-To: <20160630161317.GC26679@e104818-lin.cambridge.arm.com>
References: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160630161317.GC26679@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu_2Sko-rK6GQbfZ3fMZ3UjXbGk2VxK-UFvF8mv-61pUfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2016 at 18:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Jun 29, 2016 at 02:51:25PM +0200, Ard Biesheuvel wrote:
>> Ard Biesheuvel (4):
>>   arm64: mm: add param to force create_pgd_mapping() to use page
>>     mappings
>>   arm64: efi: always map runtime services code and data regions down to
>>     pages
>>   arm64: efi: avoid block mappings for unaligned UEFI memory regions
>>   arm64: mm: fold init_pgd() into __create_pgd_mapping()
>>
>> Catalin Marinas (1):
>>   arm64: mm: Remove split_p*d() functions
>
> I plan to queue these patches for 4.8. Do you have any other patches
> based on these so that I need to create a separate branch? Otherwise,
> I'll just push them on top of arm64 for-next/core branch.
>

No, they can go right on top of arm64/for-next/core AFAICT
