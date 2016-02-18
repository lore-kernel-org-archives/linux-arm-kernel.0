From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Feb 2016 19:27:18 +0100
Subject: [PATCH v6sub1 00/11] arm64: split linear and kernel mappings
In-Reply-To: <20160218182509.GG2538@e104818-lin.cambridge.arm.com>
References: <1455627162-31600-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160218182509.GG2538@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu_UqoYB5QAWOU9_iZDoRO=rqHu8o87JboSAqNqOhoOCXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 February 2016 at 19:25, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Feb 16, 2016 at 01:52:31PM +0100, Ard Biesheuvel wrote:
>> Ard Biesheuvel (11):
>>   of/fdt: make memblock minimum physical address arch configurable
>>   of/fdt: factor out assignment of initrd_start/initrd_end
>>   arm64: prevent potential circular header dependencies in asm/bug.h
>>   arm64: add support for ioremap() block mappings
>>   arm64: introduce KIMAGE_VADDR as the virtual base of the kernel region
>>   arm64: pgtable: implement static [pte|pmd|pud]_offset variants
>>   arm64: decouple early fixmap init from linear mapping
>>   arm64: kvm: deal with kernel symbols outside of linear mapping
>>   arm64: move kernel image to base of vmalloc area
>>   arm64: defer __va translation of initrd_start and initrd_end
>>   arm64: allow kernel Image to be loaded anywhere in physical memory
>
> I queued this patches (again) for 4.6. I'll wait a few days with the
> rest of KASLR until these get a bit more coverage in -next.
>
> Thanks.
>

Fingers crossed :-)
