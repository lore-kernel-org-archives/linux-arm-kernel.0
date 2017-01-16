From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 16 Jan 2017 18:08:47 +0800
Subject: [Question] A question about arm64 pte
Message-ID: <d284f510-f025-db84-f21e-a5b167d4bcd2@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
I have question about arm64 pte.

For arm64, PTE_WRITE?== PTE_DBM? is to mark whether the page is writable,
and PTE_DIRTY is to mark whether the page is dirty.
However, PTE_RDONLY is only cleared when both PTE_WRITE and PTE_DIRTY are set.

Is that means that the page is still writable when PTE_RDONLY is set with PTE_WRITE?
But in ARM Architecture Reference Manual for ARMv8,
when PTE_RDONLY is set(AP[2:1] = 0b1x), Acess from EL1 is Ready only?

so what is the really means of the PTE_RDONLY? could some one help to explain it?

Thanks
Yisheng Xie
