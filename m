From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 Mar 2015 13:43:44 +0100
Subject: [PATCH] KVM: vgic: add virt-capable compatible strings
In-Reply-To: <1425566864-5509-1-git-send-email-mark.rutland@arm.com>
References: <1425566864-5509-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20150311124344.GA14799@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 02:47:44PM +0000, Mark Rutland wrote:
> Several dts only list "arm,cortex-a7-gic" or "arm,gic-400" in their GIC
> compatible list, and while this is correct (and supported by the GIC
> driver), KVM will fail to detect that it can support these cases.
> 
> This patch adds the missing strings to the VGIC code. The of_device_id
> entries are padded to keep the probe fucntion data aligned.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Michal Simek <monstr@monstr.eu>

Applied, thanks.

-Christoffer
