From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 28 Dec 2014 19:20:47 +0100
Subject: [PATCH] arm64: KVM: Fix TLB invalidation by IPA/VMID
In-Reply-To: <1419009527-21565-1-git-send-email-marc.zyngier@arm.com>
References: <1419009527-21565-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141228182047.GA29460@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 05:18:47PM +0000, Marc Zyngier wrote:
> It took about two years for someone to notice that the IPA passed
> to TLBI IPAS2E1IS must be shifted by 12 bits. Clearly our reviewing
> is not as good as it should be...
> 
> Paper bag time for me.
> 
> Reported-by: Mario Smarduch <m.smarduch@samsung.com>
> Tested-by: Mario Smarduch <m.smarduch@samsung.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks, applied to queue.

-Christoffer
