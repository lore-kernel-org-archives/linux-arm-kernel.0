From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Nov 2014 20:30:29 +0100
Subject: [PATCH v3 14/19] arm/arm64: KVM: split GICv2 specific emulation
 code from vgic.c
In-Reply-To: <1414776414-13426-15-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-15-git-send-email-andre.przywara@arm.com>
Message-ID: <20141104193029.GQ16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:49PM +0000, Andre Przywara wrote:
> vgic.c is currently a mixture of generic vGIC emulation code and
> functions specific to emulating a GICv2. To ease the addition of
> GICv3, split off strictly v2 specific parts into a new file
> vgic-v2-emul.c.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
