From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 20:07:29 +0200
Subject: [PATCH] arm64: KVM: Enable minimalistic support for Cortex-A53
In-Reply-To: <1400605563-25533-1-git-send-email-marc.zyngier@arm.com>
References: <1400605563-25533-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140525180729.GK3866@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 06:06:03PM +0100, Marc Zyngier wrote:
> In order to allow KVM to run on Cortex-A53 implementations, wire the
> minimal support required.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

ack,

I've applied this to kvmarm/next.

-Christoffer
