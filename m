From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Feb 2018 11:29:43 +0000
Subject: [PATCH] arm64: Add missing Falkor part number for branch
 predictor hardening
In-Reply-To: <86po5ah9fj.wl-marc.zyngier@arm.com>
References: <1518398175-28378-1-git-send-email-shankerd@codeaurora.org>
 <86po5ah9fj.wl-marc.zyngier@arm.com>
Message-ID: <20180212112942.e5ojz3wtlt36uzax@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 08:57:36AM +0000, Marc Zyngier wrote:
> On Mon, 12 Feb 2018 01:16:15 +0000,
> Shanker Donthineni wrote:
> > 
> > References to CPU part number MIDR_QCOM_FALKOR were dropped from the
> > mailing list patch due to mainline/arm64 branch dependency. So this
> > patch adds the missing part number.
> > 
> > Fixes: ec82b567a74f ("arm64: Implement branch predictor hardening for Falkor")
> > Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
[...]
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I'd suggest this goes via the arm64 tree as a matter of consistency
> with the rest of the variant-2 series.

Queued for -rc2. Thanks.

-- 
Catalin
