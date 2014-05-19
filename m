From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 May 2014 11:46:33 +0100
Subject: [PATCH 1/1] arm64: TLB maintainance: Implement flush_kern_tlb_page
In-Reply-To: <1400495665-48279-2-git-send-email-ritesh.harjani@gmail.com>
References: <1400495665-48279-1-git-send-email-ritesh.harjani@gmail.com>
 <1400495665-48279-2-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <20140519104632.GI5113@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 11:34:25AM +0100, ritesh.harjani at gmail.com wrote:
> From: Ritesh Harjani <ritesh.harjani@gmail.com>
> 
> Implement flush_kern_tlb_page mentioned in the header
> comment of arch/arm64/include/asm/tlbflush.h

Alternatively, clean-up the comment.

-- 
Catalin
