From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2016 15:07:38 +0000
Subject: [PATCHv3 00/18] arm64: mm: rework page table creation
In-Reply-To: <1453722312-23076-1-git-send-email-mark.rutland@arm.com>
References: <1453722312-23076-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160128150737.GB20099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 11:44:54AM +0000, Mark Rutland wrote:
> Catalin, how do you want to take this? Are you happy to merge my
> arm64/pagetable-rework branch, or would you prefer to pick the patches? Arnd
> has acked the asm-generic patch [4] and is happy for it to go via the arm64
> tree, and everything else is your domain.

I picked them from the list and added Jeremy's Tested-by. I pushed the
branch here in case anyone wants to base their patches on top (I don't
plan to rebase it):

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/pgtable

Thanks.

-- 
Catalin
