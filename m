From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 1 Mar 2016 13:54:10 +0000
Subject: [PATCH] arm64: KVM: Move kvm_call_hyp back to its original
 localtion
In-Reply-To: <1456837964-10325-1-git-send-email-marc.zyngier@arm.com>
References: <1456837964-10325-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160301135410.GA30614@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2016 at 01:12:44PM +0000, Marc Zyngier wrote:
> In order to reduce the risk of a bad merge, let's move the new
> kvm_call_hyp back to its original location in the file. This has
> zero impact from a code point of view.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Catalin,
> 
> Would you mind merging this on top of arm64/for-next/core? I just
> verified that this prevents yet another mismerge between the arm64 and
> KVM trees.

Applied. Thanks.

-- 
Catalin
