From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 24 Nov 2014 10:48:49 +0100
Subject: [PATCH v4 1/3] KVM: arm/arm64: unset CONFIG_HAVE_KVM_IRQCHIP
In-Reply-To: <1416765420-12057-2-git-send-email-eric.auger@linaro.org>
References: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
 <1416765420-12057-2-git-send-email-eric.auger@linaro.org>
Message-ID: <20141124094849.GI3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 23, 2014 at 06:56:58PM +0100, Eric Auger wrote:
> CONFIG_HAVE_KVM_IRQCHIP is needed to support IRQ routing (along
> with irq_comm.c and irqchip.c usage). This is not the case for
> arm/arm64 currently.
> 
> This patch unsets the flag for both arm and arm64.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>

I don't fully understand why we used to have these and we don't need
them anymore.  Was it just a stupid bug in the past?

Anyhow, looks reasonable:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

-Christoffer
