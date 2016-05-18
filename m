From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 14:33:37 +0200
Subject: [PATCH v4 24/56] KVM: arm/arm64: vgic-new: Add CTLR, TYPER and
 IIDR handlers
In-Reply-To: <1463392481-26583-25-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-25-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518123337.GF3827@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:12AM +0100, Andre Przywara wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Those three registers are v2 emulation specific, so their implementation
> lives entirely in vgic-mmio-v2.c. Also they are handled in one function,
> as their implementation is pretty simple.
> When the guest enables the distributor, we kick all VCPUs to get
> potentially pending interrupts serviced.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
