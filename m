From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 17 Jul 2014 23:56:30 +0900
Subject: [PATCH v7 00/11] arm64: Support 4 levels of translation tables
In-Reply-To: <B063E1CA-27E4-4A0B-BDAB-CB57014348A5@gmail.com>
References: <B063E1CA-27E4-4A0B-BDAB-CB57014348A5@gmail.com>
Message-ID: <7AA60A91-3246-4524-8B2C-D21026726947@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Jul 2014 20:09:41 +0100, Catalin Marinas wrote:
> Hi,
> 
> I've taken over Jungseok's 4-level page table series here:
> 
> 
> https://lkml.kernel.org/g/000001cf6dc6$03ded0c0$0b9c7240$@samsung.com
> 
> 
> I kept the same series numbering, so this is normally version 7. Changes
> since v6:
> 
> - Additional fixes for duplicate (SWAPPER|IDMAP)_DIR_SIZE definitions
> - Removed the fixmap pmd from swapper_pg_dir populated in head.S
> - Several clean-ups in Jungseok's patches (annotated above my
>  signed-off-by line)
> - Removal of the pgtable-*level-hwdef.h files
> - Converting levels config options to int ARM64_PGTABLE_LEVELS
> 
> Important change: I dropped the KVM support for 4 levels temporarily. I
> plan to revive them but didn't have for v7.
> 
> You can also access the branch here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64 pgtable-4levels
> 
> The branch is on top of the arm64 for-next/core branch.
> 
> Thanks.

Hi Catalin,

I've reviewed the whole patches. It's better and neater than the previous version.
I really thank you for improving this series.

I will leave a minor comment on 07/11 patch.

- Jungseok Lee
