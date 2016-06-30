From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Jun 2016 17:13:18 +0100
Subject: [PATCH 0/5] arm64: avoid block entries that we need to split later
In-Reply-To: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160630161317.GC26679@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 02:51:25PM +0200, Ard Biesheuvel wrote:
> Ard Biesheuvel (4):
>   arm64: mm: add param to force create_pgd_mapping() to use page
>     mappings
>   arm64: efi: always map runtime services code and data regions down to
>     pages
>   arm64: efi: avoid block mappings for unaligned UEFI memory regions
>   arm64: mm: fold init_pgd() into __create_pgd_mapping()
> 
> Catalin Marinas (1):
>   arm64: mm: Remove split_p*d() functions

I plan to queue these patches for 4.8. Do you have any other patches
based on these so that I need to create a separate branch? Otherwise,
I'll just push them on top of arm64 for-next/core branch.

Thanks.

-- 
Catalin
