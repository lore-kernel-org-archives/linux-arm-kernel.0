From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Nov 2015 17:59:08 +0100
Subject: [PATCH 0/2] arm64: KVM: Fixes for 4.4-rc2
In-Reply-To: <1447669698-15939-1-git-send-email-marc.zyngier@arm.com>
References: <1447669698-15939-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151124165908.GA18855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 10:28:16AM +0000, Marc Zyngier wrote:
> Here's a couple of fixes for KVM/arm64:
> 
> - The first one addresses a misinterpretation of the architecture
>   spec, leading to the mishandling of I/O accesses generated from an
>   AArch32 guest using banked registers.
> 
> - The second one is a workaround for a Cortex-A57 erratum.
> 
Thanks, applied with cosmetic fixes and cc'ed to stable.

-Christoffer
