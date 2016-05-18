From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 18 May 2016 11:43:41 +0100
Subject: [PATCH v3 08/55] KVM: arm/arm64: Get rid of vgic_cpu->nr_lr
In-Reply-To: <1462531568-9799-9-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-9-git-send-email-andre.przywara@arm.com>
Message-ID: <573C475D.30005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> The number of list registers is a property of the underlying system, not
> of emulated VGIC CPU interface.
> 
> As we are about to move this variable to global state in the new vgic
> for clarity, move it from the legacy implementation as well to make the
> merge of the new code easier.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre.
