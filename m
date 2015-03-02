From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 2 Mar 2015 10:52:24 -0800
Subject: [PATCH 3/3] arm64: KVM: Fix outdated comment about VTCR_EL2.PS
In-Reply-To: <1424883340-29940-4-git-send-email-marc.zyngier@arm.com>
References: <1424883340-29940-1-git-send-email-marc.zyngier@arm.com>
 <1424883340-29940-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150302185224.GF10137@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:55:40PM +0000, Marc Zyngier wrote:
> Commit 87366d8cf7b3 ("arm64: Add boot time configuration of
> Intermediate Physical Address size") removed the hardcoded setting
> of VTCR_EL2.PS to use ID_AA64MMFR0_EL1.PARange instead, but didn't
> remove the (now rather misleading) comment.
> 
> Fix the comments to match reality (at least for the next few minutes).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
