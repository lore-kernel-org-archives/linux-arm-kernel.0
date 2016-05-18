From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 16:15:42 +0200
Subject: [PATCH v4 26/56] KVM: arm/arm64: vgic-new: Add PENDING registers
 handlers
In-Reply-To: <1463392481-26583-27-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-27-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518141542.GD6666@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:14AM +0100, Andre Przywara wrote:
> The pending register handlers are shared between the v2 and v3
> emulation, so their implementation goes into vgic-mmio.c, to be easily
> referenced from the v3 emulation as well later.
> For level triggered interrupts the real line level is unaffected by
> this write, so we keep this state separate and combine it with the
> device's level to get the actual pending state.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
