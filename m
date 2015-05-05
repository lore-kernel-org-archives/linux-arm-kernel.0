From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 5 May 2015 13:57:07 +0200
Subject: [PATCH] KVM: arm64: add active register handling to GICv3
 emulation as well
In-Reply-To: <1429815713-13684-1-git-send-email-andre.przywara@arm.com>
References: <1429815713-13684-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150505115707.GA19385@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 08:01:53PM +0100, Andre Przywara wrote:
> Commit 47a98b15ba7c ("arm/arm64: KVM: support for un-queuing active
> IRQs") introduced handling of the GICD_I[SC]ACTIVER registers,
> but only for the GICv2 emulation. For the sake of completeness and
> as this is a pre-requisite for save/restore of the GICv3 distributor
> state, we should also emulate their handling in the distributor and
> redistributor frames of an emulated GICv3.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Applied to queue, thanks!
-Christoffer
