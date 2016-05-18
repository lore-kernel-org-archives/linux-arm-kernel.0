From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 16:15:55 +0200
Subject: [PATCH v4 34/56] KVM: arm/arm64: vgic-new: Add GICv3 CTLR, IIDR,
 TYPER handlers
In-Reply-To: <1463392481-26583-35-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-35-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518141555.GG6666@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:22AM +0100, Andre Przywara wrote:
> As in the GICv2 emulation we handle those three registers in one
> function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
